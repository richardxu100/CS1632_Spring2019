class FileIOHelpers
  def self.write_to_file(lines, output_file)
    File.open(output_file, 'w') do |file|
      lines.each do |line|
        file.write(line)
        file.write("\n")
      end
    end
  end

  def self.read_file(filepath)
    lines = []
    File.open(filepath, 'r').each_line do |line|
      lines << line.chomp
    end
    lines
  end
end
