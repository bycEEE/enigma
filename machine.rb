require 'pry'

class Machine  
  attr_reader :plugboard, :rotor_fast, :rotor_medium, :rotor_slow, :reflector

  def initialize
    @plugboard = make_plugboard
    @rotor_fast, @rotor_medium, @rotor_slow = make_rotor, make_rotor, make_rotor
    @reflector = make_reflector
  end

  # The rotor maps each letter of the alphabet to a different one
  # Implement logic to avoid a letter becoming itself
  # Revise this to pick 3 from a set of 5
  # TODO: Generate rotors to give to others
  def make_rotor
    alphabet = ("A".."Z").to_a
    alphabet.zip(alphabet.shuffle).to_h
  end

  # The plugboard takes 10 different letters and maps each to a different one
  # Implement logic to avoid letter becoming itself
  # Revise this to take an argument of 10 alphabet pairs
  def make_plugboard
    alphabet = ("A".."Z").to_a
    first_plugs = ("A".."Z").to_a.shuffle.first(10)
    second_plugs = (alphabet - first_plugs).first(10).shuffle
    plugs = first_plugs.zip(second_plugs).to_h
    plugs.merge(plugs.invert)
  end

  # The reflector maps all the letters in the alphabet to any other letter, and maps those letters back
  # Implement logic to avoid letter becoming itself
  # Revise this to have a more random mapping
  # TODO: Generate a reflector to give to others
  def make_reflector
    shuffled_alphabet = ("A".."Z").to_a.shuffle
    mapped = shuffled_alphabet.first(13).zip(shuffled_alphabet.last(13)).to_h
    mapped.merge(mapped.invert)
  end

  def rotate_rotor(rotor)
    rotor.map { |k, v| [k == "Z" ? "A" : k.next, v] }.to_h
  end

  def input(string)
    rotor_fast, rotor_medium, rotor_slow = @rotor_fast.dup, @rotor_medium.dup, @rotor_slow.dup
    plugboard = @plugboard.dup
    reflector = @reflector.dup
 
    string.chars.each_with_index.map do |char, index|
      rotor_fast = rotate_rotor(rotor_fast)
      rotor_medium = rotate_rotor(rotor_medium) if index % 25 == 0
      rotor_slow = rotate_rotor(rotor_slow) if index % 25*25 == 0

      char = plugboard[char].nil? ? char : plugboard[char]

      char = rotor_fast[char]
      char = rotor_medium[char]
      char = rotor_slow[char]
   
      char = reflector[char]
   
      char = rotor_slow.invert[char]
      char = rotor_medium.invert[char]
      char = rotor_fast.invert[char]
   
      plugboard[char].nil? ? char : plugboard[char]
    end.join
  end
end

machine = Machine.new
text = 'HIMOMTHISISMYENIGMAMACHINE'
puts "#{text} has been encryped to #{machine.input(text)}"