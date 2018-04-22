# INEGI (Geospatial database)
> Imports [INEGI geospatial database][inegi] into a readable CSV

Every application interacting with the INGEI's geospatial data, uses a
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

## References
- [guivaloz/INEGI](https://github.com/guivaloz/INEGI)
- [evilmartians/fias](https://github.com/evilmartians/fias)

[inegi]: http://www.inegi.org.mx/geo/contenidos/geoestadistica/

## License
The MIT License (MIT)

Copyright (c) 2018 Mr. Outis

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
