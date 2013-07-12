class Animal
  attr_accessor :life, :attendants
  def initialize
    self.life = true
    self.attendants = []
  end

  def talk(speech)
    puts speech
  end

  def miserable
    has_pain?
  end

  def meets(other_animal)
    self.attendants << other_animal
  end

  def has_attendant?(attendant)
    self.attendants.include? attendant
  end

  def alive?
    self.life
  end
end

class Donkey < Animal
  attr_accessor :splinter
  def has_pain?
    alive? && splinter
  end
end

class Wolf < Animal
  def tear_apart(animal)
    animal.life = nil
  end

  def has_pain?
    false
  end
end
