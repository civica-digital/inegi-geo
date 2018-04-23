module Inegi; end
module Inegi::Geo; end

require_relative 'geo/downloader'
require_relative 'geo/transformer'
require_relative 'geo/railtie' if defined?(Rails)
