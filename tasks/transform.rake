require 'inegi/geo'

namespace :inegi do
  namespace :geo do
    desc 'Transform the downloaded datasets from DBF to CSV'
    task :transform do
      Inegi::Geo::Transformer.call
    end
  end
end
