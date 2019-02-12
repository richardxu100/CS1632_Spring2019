require_relative './file_io_helpers.rb'

# Provides encryption and decyrption features
class Security
  def self.generate_key(password)
    ordinal_values = password.split('').map(&:ord)
    ordinal_values.reduce(:+) + 1
  end

  def self.encrypt_lines(lines, key)
    encrypted_file = lines.map do |line|
      line_characters = line.split('')
      new_line_characters = line_characters.map do |char|
        char.ord != 32 ? ((char.ord + key) % 128).chr : char
      end
      new_line_characters
    end
    encrypted_file
  end

  def self.decrypt_lines(lines, key)
    decrypted_file = lines.map do |line|
      line_characters = line.split('')
      new_line_characters = line_characters.map do |char|
        char.ord != 32 ? ((char.ord - key) % 128).chr : char
      end
      new_line_characters
    end
    decrypted_file
  end

  def self.generate_encrypted_file(filepath, password)
    raise "File at #{filepath} not found" unless File.exist?(filepath)

    key = generate_key(password)
    lines = FileIOHelpers.read_file(filepath)
    encrypted_lines = encrypt_lines(lines, key)
    encrypted_lines.map(&:join)
  end

  def self.generate_decrypted_file(filepath, password)
    key = generate_key(password)
    lines = FileIOHelpers.read_file(filepath)
    decrypted_lines = decrypt_lines(lines, key)
    decrypted_lines.map(&:join)
  end
end
