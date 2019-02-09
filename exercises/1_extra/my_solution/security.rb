require_relative './file_io_helpers.rb'

class Security
  def initialize(password)
    @key = generate_key(password)
  end

  def generate_key(password)
    ordinal_values = password.split('').map(&:ord)
    ordinal_values.reduce(:+) + 1
  end

  # should make this a private method
  def encrypt_lines(lines)
    encrypted_file = lines.map do |line|
      line_characters = line.split('')
      new_line_characters = line_characters.map do |char|
        char.ord != 32 ? ((char.ord + @key) % 128).chr : char
      end
      new_line_characters
    end
    encrypted_file
  end

  def generate_encrypted_file(filepath)
    raise "File at #{filepath} not found" unless File.exist?(filepath)

    lines = FileIOHelpers.read_file(filepath)
    encrypted_lines = encrypt_lines(lines)
    encrypted_lines.map(&:join)
  end

  # should make this a private method
  def decrypt_lines(lines)
    decrypted_file = lines.map do |line|
      line_characters = line.split('')
      new_line_characters = line_characters.map do |char|
        char.ord != 32 ? ((char.ord - @key) % 128).chr : char
      end
      new_line_characters
    end
    decrypted_file
  end

  def generate_decrypted_file(filepath)
    lines = FileIOHelpers.read_file(filepath)
    decrypted_lines = decrypt_lines(lines)
    decrypted_lines.map(&:join)
  end
end
