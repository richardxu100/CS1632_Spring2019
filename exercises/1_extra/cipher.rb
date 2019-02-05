def read_file(input_file)
  lines = []
  File.open(input_file, 'r').each_line do |line|
    lines << line.chomp
  end
  lines
end

def generate_key(password)
  ordinal_values = password.split('').map { |char| char.ord }
  ordinal_values.reduce(:+) + 1
end

def generate_encrypted_file(input_file)
  password = "bonbon"
  lines = read_file(input_file)
  key = generate_key(password)
  encrypted_file = lines.map do |line|
    line_characters = line.split('')
    new_line_characters = line_characters.map do |char|
      if char.ord != 32
        (char.ord + key) % 128
      else
        char.ord
      end
    end
    new_line_characters
  end
  return encrypted_file
end

print(generate_encrypted_file('./test.txt'))