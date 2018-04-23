require 'zip'
require 'dbf'

class Inegi::Geo::Transformer
  def self.call
    new.call
  end

  def call
    unzip_datasets unless already_unzipped?
    dbf_to_csv unless already_csv?
  end

  protected

  def initialize
    @directory = File.expand_path('.', 'datasets')
  end

  private

  def unzip_datasets
    files_with(extension: 'zip').each { |filename| unzip(filename) }
  end

  def unzip(filename)
    destination = filename.sub('.zip', '.dbf')
    puts "UNZIP: #{File.basename(filename)} -> #{File.basename(destination)}"

    Zip::File.open(filename) do |zip_file|
      zip_file.each { |entry| entry.extract(destination) }
    end
  end

  def already_unzipped?
    files_with(extension: 'dbf').any?
  end

  def dbf_to_csv
    files_with(extension: 'dbf').each do |filename|
      basename = File.basename(filename)
      destination = filename.sub('.dbf', '.csv')
      table = DBF::Table.new(filename)

      CSV.open(destination, 'w', force_quotes: true) do |csv|
        csv << translate_header(table.column_names)
        table.each { |record| csv << record.to_a.map(&latin1_to_utf8) }
      end

      puts "CONVERTED: #{basename} -> #{basename.sub('dbf', 'csv')}"
    end
  end

  def translate_header(header)
    dictionary = {
      CVE_ENT: 'state_code',
      CVE_MUN: 'municipality_code',
      CVE_CAB: 'head_code',
      CVE_LOC: 'locality_code',
      CVE_CAP: 'capital_code',
      NOM_ENT: 'state_name',
      NOM_ABR: 'state_abbreviation',
      NOM_CAP: 'capital_name',
      NOM_MUN: 'municipality_name',
      NOM_CAB: 'head_name',
      NOM_LOC: 'locality_name',
      PTOT: 'total_population',
      PMAS: 'masculine_population',
      PFEM: 'femenine_population',
      VTOT: 'inhabited_residences',
    }

    header.map { |column| dictionary[column.to_sym] }
  end

  def already_csv?
    files_with(extension: 'csv').any?
  end

  def latin1_to_utf8
    proc { |str| str.force_encoding('ISO-8859-1').encode('UTF-8') }
  end

  def files_with(extension:)
    Dir[File.join(@directory, "*.#{extension}")]
  end
end
