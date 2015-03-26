require_relative 'machine'
require_relative 'plugboard'
require_relative 'rotor'
require_relative 'reflector'
class Enigma
  def call
    puts "Welcome to the Enigma Machine"
    run
  end
    
  def get_user_input
    gets.chomp.strip
  end

  def run
    print "Please select an option: "
    input = get_user_input

    case input
    when "encrypt"
      encrypt
    when "decrypt"
      decrypt
    when "generate rotor"
      generate_rotor
    when "generate reflector"
      generate_reflector
    when "generate plugboard"
      generate_plugboard
    when "help"
      help
    when "exit"
      exit
    else
      puts "Invalid input"
    end
  end

  def encrypt
    print "Input phrase to encrypt: "
    input = get_user_input.upcase
    my_enigma = Machine.new
    puts "Your encrypted phrase is: #{my_enigma.encrypt(input)}"
  end

  def decrypt
    print "Input phrase to decrypt: "
    input = get_user_input.upcase
    my_enigma = Machine.new
    puts "Your decrypted phrase is: #{my_enigma.encrypt(input)}"
  end

  def generate_rotor
    print "Select which rotor to generate (1-5). Type 'all' to generate all rotors"
    input = get_user_input

    if input.is_a? Fixnum
      Rotor.generate_rotor(input)
      puts "Rotor successfully generated"
    elsif input == "all"
      Rotor.generate_rotor(1)
      Rotor.generate_rotor(2)
      Rotor.generate_rotor(3)
      Rotor.generate_rotor(4)
      Rotor.generate_rotor(5)
      puts "Rotors successfully generated"
    else
      puts "Invalid input"
    end
  end

  def generate_reflector
    Reflector.generate_reflector
    puts "Reflector generated"
  end

  def generate_plugboard
    Plugboard.generate_plugboard
    puts "Plugboard generated"
  end

  def help
    puts "Type 'encrypt' to encrypt your message"
    puts "Type 'decrypt' to decrypt your message"
    puts "Type 'generate rotor' followed by a number (1-5) to generate that rotor"
    puts "Type 'generate reflector' to generate a reflector"
    puts "Type 'exit' to exit"
    puts "Type 'help' to view this menu again"
  end
end

Enigma.new.call