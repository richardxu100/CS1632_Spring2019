require_relative './file_io_helpers.rb'
require_relative './security.rb'

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
security = Security.new(password)

if operation == 'e'
  FileIOHelpers.write_to_file(
    security.generate_encrypted_file(filepath),
    "#{filepath[0...-4]}_encrypted.txt"
  )
elsif operation == 'd'
  FileIOHelpers.write_to_file(
    security.generate_decrypted_file(filepath),
    "#{filepath[0...-14]}_decrypted.txt"
  )
end
