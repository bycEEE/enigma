require 'pry'
require_relative 'plugboard'
require_relative 'rotor'
require_relative 'reflector'

class Machine  
  attr_accessor :rotor_fast, :rotor_medium, :rotor_slow
  attr_reader :plugboard, :reflector

  def initialize
    @plugboard = Plugboard.new
    @reflector = Reflector.new
  end

  def encrypt(input)
    input.chars.map do |char|
      encrypt_char(char)
    end.join
  end

  def print_message(message)
    puts message
  end

  private
  def encrypt_char(char)
    rotate_rotors
    char = plugboard.translate(char).nil? ? char : plugboard.translate(char)
    char = encrypt_through_rotor(char)
    char = reflector.translate(char)
    char = encrypt_through_rotor_inverse(char)
    plugboard.inverse_translate(char).nil? ? char : plugboard.inverse_translate(char)
  end

  def rotate_rotors
    self.rotor_fast = rotor_fast.rotate
    self.rotor_medium = rotor_medium.rotate if rotor_fast.offset % 25 == 0
    self.rotor_slow = rotor_slow.rotate if rotor_medium.offset % 25*25 == 0
  end

  def encrypt_through_rotor(char)
    char = self.rotor_fast.translate(char)
    char = self.rotor_medium.translate(char)
    char = self.rotor_slow.translate(char)
  end

  def encrypt_through_rotor_inverse(char)
    char = self.rotor_slow.inverse_translate(char)
    char = self.rotor_medium.inverse_translate(char)
    char = self.rotor_fast.inverse_translate(char)
  end
end

# ROTORS 1 2 3 | 21 3 11
# HIMOMTHISISMYENIGMAMACHINE has been encrypted to BTFDYXTCZRZLCJSRDLHFJDUREO
# BTFDYXTCZRZLCJSRDLHFJDUREO has been decrypted to HIMOMTHISISMYENIGMAMACHINE