require 'inegi/geo'

namespace :inegi do
  namespace :geo do
    desc 'Download content from INEGI into datasets/'
    task :download do
      Inegi::Geo::Downloader.call
    end
  end
end
