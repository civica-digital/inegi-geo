$:.push File.expand_path('../lib', __FILE__)

Gem::Specification.new do |s|
  s.name        = 'inegi-geo'
  s.version     = '0.0.1'
  s.authors     = ['mroutis']
  s.email       = ['outis@civica.digital']
  s.summary     = 'A Ruby wrapper for INEGI geospatial database'
  s.files       = ['lib/hola.rb']
  s.homepage    = 'https://github.com/civica-digital/inegi-geo'
  s.license     = 'MIT'

  s.add_dependency 'dbf'
  s.add_dependency 'down'
  s.add_dependency 'rubyzip'

  s.add_development_dependency 'bundler', '~> 1.16'
end
