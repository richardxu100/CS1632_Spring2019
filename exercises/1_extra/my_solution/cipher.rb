def read_file(filepath)
  lines = []
  File.open(filepath, 'r').each_line do |line|
    lines << line.chomp
  end
  lines
end

def generate_key(password)
  ordinal_values = password.split('').map(&:ord)
  ordinal_values.reduce(:+) + 1
end

def encrypt_lines(lines, key)
  encrypted_file = lines.map do |line|
    line_characters = line.split('')
    new_line_characters = line_characters.map do |char|
      char.ord != 32 ? ((char.ord + key) % 128).chr : char
    end
    new_line_characters
  end
  encrypted_file
end

def generate_encrypted_file(filepath, password)
  raise "File at #{filepath} not found" unless File.exist?(filepath)

  lines = read_file(filepath)
  key = generate_key(password)
  encrypted_lines = encrypt_lines(lines, key)
  encrypted_lines.map(&:join)
end

def write_to_file(lines, output_file)
  File.open(output_file, 'w') do |file|
    lines.each do |line|
      file.write(line)
      file.write("\n")
    end
  end
end

def decrypt_lines(lines, key)
  decrypted_file = lines.map do |line|
    line_characters = line.split('')
    new_line_characters = line_characters.map do |char|
      char.ord != 32 ? ((char.ord - key) % 128).chr : char
    end
    new_line_characters
  end
  decrypted_file
end

def generate_decrypted_file(filepath, password)
  lines = read_file(filepath)
  key = generate_key(password)
  decrypted_lines = decrypt_lines(lines, key)
  decrypted_lines.map(&:join)
end

# write_to_file(generate_encrypted_file('./test.txt'), 'rand.txt')
# puts decrypt_file('./rand.txt')

# check if the first arg is a number?
def validate_input(arguments)
  if arguments.length < 3
    raise 'Please pass in a password, e or d, and a filepath!'
  elsif arguments.length > 3
    raise 'Please pass in only password, e or d (for encrypt or decrypt), and a filepath'
  elsif !%w[e d].include?(arguments[1])
    raise "I don't recognize the operation (must be 'e' or 'd')"
  end
end

validate_input(ARGV)

password, operation, filepath = ARGV

if operation == 'e'
  write_to_file(
    generate_encrypted_file(filepath, password),
    "#{filepath[0...-4]}_encrypted.txt"
  )
elsif operation == 'd'
  write_to_file(
    generate_decrypted_file(filepath, password),
    "#{filepath[0...-14]}_decrypted.txt"
  )
end
