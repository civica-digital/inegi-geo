module Inegi::Geo
  class Railtie < Rails::Railtie
    rake_tasks do
      load File.join(File.dirname(__FILE__), '../../../tasks/download.rake')
      load File.join(File.dirname(__FILE__), '../../../tasks/transform.rake')
    end
  end
end
