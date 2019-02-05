def read_file(input_file)
  lines = []
  File.open(input_file, 'r').each_line do |line|
    lines << line.chomp
  end
  lines
end

def generate_key(password)
  ordinal_values = password.split('').map(&:ord)
  ordinal_values.reduce(:+) + 1
end

def encrypt_file(lines, key)
  encrypted_file = lines.map do |line|
    line_characters = line.split('')
    new_line_characters = line_characters.map do |char|
      char.ord != 32 ? ((char.ord + key) % 128).chr : char
    end
    new_line_characters
  end
  encrypted_file
end

def generate_encrypted_file(input_file)
  password = 'bonbon'
  lines = read_file(input_file)
  key = generate_key(password)
  encrypted_file = encrypt_file(lines, key)
  encrypted_file
end

print(read_file('./test.txt'))
print(generate_encrypted_file('./test.txt'))