$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'inegi-geo'
  s.version     = '0.0.1'
  s.authors     = ['mroutis']
  s.email       = ['outis@civica.digital']
  s.summary     = 'Imports INEGI geospatial database into a readable CSV'
  s.files       = `git ls-files -z`.split("\x0")
  s.homepage    = 'https://github.com/civica-digital/inegi-geo'
  s.license     = 'unlicense'

  s.add_dependency 'dbf', '~> 3.1'
  s.add_dependency 'down', '~> 4.4'
  s.add_dependency 'rubyzip', '~> 1.2'

  s.add_development_dependency 'bundler', '~> 1.16'
end
