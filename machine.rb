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
    output = 
    input.chars.map do |char|
      self.rotor_fast = rotor_fast.rotate
      self.rotor_medium = rotor_medium.rotate if rotor_fast.offset % 25 == 0
      self.rotor_slow = rotor_slow.rotate if rotor_medium.offset % 25*25 == 0

      char = plugboard.translate(char).nil? ? char : plugboard.translate(char)

      char = self.rotor_fast.translate(char)
      char = self.rotor_medium.translate(char)
      char = self.rotor_slow.translate(char)
   
      char = reflector.translate(char)
   
      char = self.rotor_slow.inverse_translate(char)
      char = self.rotor_medium.inverse_translate(char)
      char = self.rotor_fast.inverse_translate(char)
   
      plugboard.inverse_translate(char).nil? ? char : plugboard.inverse_translate(char)
    end.join
  end

  def print_message(message)
    puts message
  end
end

# machine = Machine.new
# text = 'HIMOMTHISISMYENIGMAMACHINE'
# puts "#{text} has been encrypted to #{encrypted = machine.input(text)}"
# machine = Machine.new
# puts "#{encrypted} has been decrypted to #{machine.input(encrypted)}"

# HIMOMTHISISMYENIGMAMACHINE has been encrypted to BTFDYXTCZRZLCJSRDLHFJDUREO
# BTFDYXTCZRZLCJSRDLHFJDUREO has been decrypted to HIMOMTHISISMYENIGMAMACHINE