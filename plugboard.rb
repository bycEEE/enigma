class Plugboard
  attr_reader :plugboard
  # The plugboard takes 10 different letters and maps each to a different one
  # Implement logic to avoid letter becoming itself
  # Revise this to take an argument of 10 alphabet pairs

  def initialize
    @plugboard = self.class.generate
  end

  def translate(char)
    plugboard[char]
  end

  def inverse_translate(char)
    plugboard.invert[char]
  end

  def self.generate
    alphabet = ("A".."Z").to_a
    first_plugs = ("A".."Z").to_a.shuffle.first(10)
    second_plugs = (alphabet - first_plugs).first(10).shuffle
    plugs = first_plugs.zip(second_plugs).to_h
    plugs.merge(plugs.invert)
  end
end