require 'down'
require 'fileutils'
require 'ostruct'

class Inegi::Geo::Downloader
  def self.call
    new.call
  end

  def call
    create_directory unless directory_exists?
    download
  end

  protected

  def initialize
    @base_url = 'http://geoweb2.inegi.org.mx/mgn2kData/catalogos/'

    @datasets = {
      states: 'cat_entidad_ENE2016.zip',
      municipalities: 'cat_municipio_NOV2017.zip',
      localities: 'cat_localidad_FEB2018.zip',
    }

    @directory = File.expand_path('.', 'datasets')

    @current_file = OpenStruct.new
  end

  private

  def create_directory
    FileUtils.mkdir(@directory)

    puts "CREATED: #{@directory}"
  end

  def directory_exists?
    File.exist?(@directory)
  end

  def download
    @datasets.each do |name, path|
      url = @base_url + path
      filename = @current_file.name = "#{name}.zip"
      destination = File.join(@directory, filename)

      next puts "ALREADY_EXIST: #{filename}" if File.exist?(destination)

      options = {
        destination: destination,
        content_length_proc: -> (size) { @current_file.size = size },
        progress_proc: -> (progress) { percent(progress) },
      }

      Down.download(url, options)

      puts "\rDOWNLOADED: #{filename}"
    end
  end

  def percent(progress)
    percentage = (100 * (progress / @current_file.size.to_f).round(2)).to_i

    print "\rDOWNLOADED: #{@current_file.name} (%#{percentage})"
  end
end
