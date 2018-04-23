# INEGI (Geospatial database)
> Imports [INEGI geospatial database][inegi] into a readable CSV

Every application interacting with the INEGI's geospatial data, uses a
standalone copy of the database, or implements its own _snowflake_ solution,
causing **inconsistencies**, missing the benefits of having a centralized
source of truth.

Unluckily we couldn't figure out how to prevent this :sweat:.

However, `inegi-geo` removes the hassle of importing the INEGI's geospatial
data into a readable CSV that you can edit to select the combinations you
want.

## Installation

Add this line to your application's `Gemfile`:
```ruby
gem 'inegi-geo'
```

And then execute:
```
$ bundle
```

Or install it yourself:
```
$ gem install inegi-geo
```

## Usage

Once the gem is installed, run the following command to **download** the dataset
and **transform** it into a CSV.

```bash
rake inegi:geo:download inegi:geo:transform

# DOWNLOADED: states.zip (%100)
# DOWNLOADED: municipalities.zip (%100)
# DOWNLOADED: localities.zip (%100)
# UNZIP: localities.zip -> localities.dbf
# UNZIP: municipalities.zip -> municipalities.dbf
# UNZIP: states.zip -> states.dbf
# CONVERTED: localities.dbf -> localities.csv
# CONVERTED: municipalities.dbf -> municipalities.csv
# CONVERTED: states.dbf -> states.csv
```

Delete the `.zip` and `.dbf` or put them on your `.gitignore` if you want
to save them locally.

```bash
rm -f datasets/*[^.csv]
```

After editing the CSV to select the columns that you want, you can use
[activerecord-import][activerecord-import] to insert the data in the CSVs into
your database.

```bash
# head -n 5 states.csv

"code","name"
"01","Aguascalientes"
"02","Baja California"
"03","Baja California Sur"
"04","Campeche"
```

```bash
# head -n 5 municipalities.csv

"state_code","code","name"
"01","001","Aguascalientes"
"01","002","Asientos"
"01","003","Calvillo"
"01","004","Cosío"
```

```bash
# head -n 5 localities.csv

"state_code","municipality_code","code","name"
"01","001","0001","Aguascalientes"
"01","001","0094","Granja Adelita"
"01","001","0096","Agua Azul"
"01","001","0100","Rancho Alegre"
```

The size of the CSVs:

```txt
Size Name
---- ----
 10M localities.csv
 68k municipalities.csv
 612 states.csv
```


_:warning: Review and understand the code before copying and pasting it._

In this example, I chose to store `State`, `Municipality`, and `Locality`.

```bash
rails generate model state code:string \
                           name:string

rails generate model municipality code:string \
                                  name:string \
                                  state_code:string \
                                  state:references

rails generate model locality code:string \
                              name:string \
                              state_code:string \
                              state:references \
                              municipality_code:string \
                              municipality:references
```

```ruby
require 'activerecord-import/base'
require 'activerecord-import/active_record/adapters/postgresql_adapter'

def import_from_csv(dataset)
  file = Rails.root.join('datasets', "#{dataset}.csv")
  klass = dataset.classify.constantize

  return if klass.count > 0

  print "\rImporting #{dataset.pluralize}..."

  klass.transaction do
    rows = CSV.read(file)
    headers = rows.delete_at(0)
    klass.import(headers, rows, validate: false)
  end

  puts "\rImported #{dataset.pluralize}: #{klass.count}"
end

def update_references
  return unless Municipality.where(state_id: nil).exists? ||
                Locality.where(municipality_id: nil).exists?

  print "\rUpdating references..."

  states = <<~SQL
    UPDATE municipalities
    SET state_id = states.id
    FROM states
    WHERE municipalities.state_code = states.code;

    UPDATE localities
    SET state_id = states.id
    FROM states
    WHERE localities.state_code = states.code;
  SQL

  municipalities = <<~SQL
    UPDATE localities
    SET municipality_id = municipalities.id
    FROM municipalities
    WHERE localities.state_code = municipalities.state_code
      AND localities.municipality_code = municipalities.code;
  SQL

  ActiveRecord::Base.connection.execute(states)
  ActiveRecord::Base.connection.execute(municipalities)

  puts "\rUpdating references: DONE"
end

import_from_csv 'states'
import_from_csv 'municipalities'
import_from_csv 'localities'
update_references
```

The code above imports the data from the CSV to the models, and update
the references. The time to run this (in my computer) is below **1 minute**.

## References
- [guivaloz/INEGI](https://github.com/guivaloz/INEGI)
- [evilmartians/fias](https://github.com/evilmartians/fias)

[inegi]: http://www.inegi.org.mx/geo/contenidos/geoestadistica/
[activerecord-import]: https://github.com/zdennis/activerecord-import

## License
This is free and unencumbered software released into the public domain.

Anyone is free to copy, modify, publish, use, compile, sell, or
distribute this software, either in source code form or as a compiled
binary, for any purpose, commercial or non-commercial, and by any
means.

In jurisdictions that recognize copyright laws, the author or authors
of this software dedicate any and all copyright interest in the
software to the public domain. We make this dedication for the benefit
of the public at large and to the detriment of our heirs and
successors. We intend this dedication to be an overt act of
relinquishment in perpetuity of all present and future rights to this
software under copyright law.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
IN NO EVENT SHALL THE AUTHORS BE LIABLE FOR ANY CLAIM, DAMAGES OR
OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE,
ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
OTHER DEALINGS IN THE SOFTWARE.

For more information, please refer to <http://unlicense.org>
