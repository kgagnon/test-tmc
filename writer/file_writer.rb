class FileWriter
  def initialize(file_path)
    @file_path = file_path
    @buffer = []
  end

  def add(line)
    @buffer << line
  end

  def write
    File.open(@file_path, "w") do |file|
      file.puts @buffer
    end
    @buffer.clear
  end
end
