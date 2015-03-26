class Rotor
  attr_accessor :rotor
  # The rotor maps each letter of the alphabet to a different one
  # Implement logic to avoid a letter becoming itself
  # Revise this to pick 3 from a set of 5
  # TODO: Generate rotors to give to others

  def initialize
    @rotor = self.class.generate
  end

  def rotate
    self.rotor = rotor.map { |k, v| [k == "Z" ? "A" : k.next, v] }.to_h
    self
  end

  def translate(char)
    rotor[char]
  end

  def inverse_translate(char)
    rotor.invert[char]
  end

  def self.generate
    alphabet = ("A".."Z").to_a
    alphabet.zip(alphabet.shuffle).to_h
  end

  def self.generate_rotor(rotor_number)
    Dir.mkdir("./parts") unless File.exists?("./parts")
    File.open("./parts/rotor_#{rotor_number}", "w") { |file| file.write(Rotor.generate) }
  end
end