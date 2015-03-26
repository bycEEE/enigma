class Reflector
  attr_reader :reflector
  # The reflector maps all the letters in the alphabet to any other letter, and maps those letters back
  # Implement logic to avoid letter becoming itself
  # Revise this to have a more random mapping

  def initialize
    @reflector = eval(File.read("./parts/reflector"))
  end

  def translate(char)
    reflector[char]
  end

  def self.generate
    shuffled_alphabet = ("A".."Z").to_a.shuffle
    mapped = shuffled_alphabet.first(13).zip(shuffled_alphabet.last(13)).to_h
    mapped.merge(mapped.invert)
  end

  def self.generate_reflector
    Dir.mkdir("./parts") unless File.exists?("./parts")
    File.open("./parts/reflector", "w") { |file| file.write(Reflector.generate) }
  end
end