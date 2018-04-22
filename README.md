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
