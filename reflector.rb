class Reflector
  attr_reader :reflector
  # The reflector maps all the letters in the alphabet to any other letter, and maps those letters back
  # Implement logic to avoid letter becoming itself
  # Revise this to have a more random mapping
  # TODO: Generate a reflector to give to others

  def initialize
    @reflector = self.class.generate
  end

  def translate(char)
    reflector[char]
  end

  def self.generate
    shuffled_alphabet = ("A".."Z").to_a.shuffle
    mapped = shuffled_alphabet.first(13).zip(shuffled_alphabet.last(13)).to_h
    mapped.merge(mapped.invert)
  end
end