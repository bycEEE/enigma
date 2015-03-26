require 'pry'
require_relative 'plugboard'
require_relative 'rotor'
require_relative 'reflector'

class Machine  
  attr_reader :plugboard, :rotor_fast, :rotor_medium, :rotor_slow, :reflector

  def initialize
    @plugboard = Plugboard.new
    @rotor_fast, @rotor_medium, @rotor_slow = Rotor.new, Rotor.new, Rotor.new
    @reflector = Reflector.new
  end

  def input(string)
    rotor_fast, rotor_medium, rotor_slow = @rotor_fast.dup, @rotor_medium.dup, @rotor_slow.dup
    plugboard = @plugboard.dup
    reflector = @reflector.dup
 
    string.chars.each_with_index.map do |char, index|
      rotor_fast = rotor_fast.rotate
      rotor_medium = rotor_medium.rotate if index % 25 == 0
      rotor_slow = rotor_slow.rotate if index % 25*25 == 0

      char = plugboard.translate(char).nil? ? char : plugboard.translate(char)

      char = rotor_fast.translate(char)
      char = rotor_medium.translate(char)
      char = rotor_slow.translate(char)
   
      char = reflector.translate(char)
   
      char = rotor_slow.inverse_translate(char)
      char = rotor_medium.inverse_translate(char)
      char = rotor_fast.inverse_translate(char)
   
      plugboard.inverse_translate(char).nil? ? char : plugboard.inverse_translate(char)
    end.join
  end
end

machine = Machine.new
text = 'HIMOMTHISISMYENIGMAMACHINE'
puts "#{text} has been encrypted to #{encrypted = machine.input(text)}"
puts "#{encrypted} has been decrypted to #{machine.input(encrypted)}"