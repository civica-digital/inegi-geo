# INEGI (Geospatial database)
> `inegi-geo` a ruby wrapper for the Mexican [INEGI geospatial database][inegi]

Every application that interacts with the INGEI's database implements their
own _snowflake_ solution, or using a standalone copy of the data, causing
**inconsistencies**, and missing the benefits of having a
centralized source of truth.

`inegi-geo` allows you to:
- Import the INEGI's geospatial database into **PostgreSQL**

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
