class Rotor
  attr_accessor :rotor, :offset
  attr_reader :rotor_number
  # The rotor maps each letter of the alphabet to a different one
  # Implement logic to avoid a letter becoming itself
  # Revise this to pick 3 from a set of 5

  def initialize(rotor_number, offset)
    @rotor_number = rotor_number
    @rotor = eval(File.read("./parts/rotor_#{rotor_number}"))
    @offset = offset
    @rotor = set_position
  end

  def rotate
    self.rotor = rotor.map { |k, v| [k == "Z" ? "A" : k.next, v] }.to_h
    increase_offset
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

  private
  def increase_offset
    self.offset += 1
    self.offset = 0 if offset == 26
  end

  def set_position
    offset.times { self.rotor = rotor.map { |k, v| [k == "Z" ? "A" : k.next, v] }.to_h }
    rotor
  end
end