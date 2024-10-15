require "json"

class JsonReader
  attr_reader :data

  def initialize(file_name)
    @file_name = file_name
    @data = read_json
  end

  def read_json
    file_path = File.join(Dir.pwd, "data", @file_name)
    if File.exist?(file_path)
      file = File.read(file_path)
      JSON.parse(file)
    else
      raise "File #{@file_name} not found in the 'data' directory"
    end
  end

  # Méthode à surcharger pour validation personnalisée dans les sous-classes
  def validate_data
    raise NotImplementedError, "Subclasses must implement a custom validation method"
  end
end
