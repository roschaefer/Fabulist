class Animal
  attr_accessor :life, :attendants, :friends
  def initialize
    self.life = true
    self.attendants = []
    self.friends = []
  end

  def talk(speech)
    puts speech
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

  def is(state)
    @state = state
  end

  def is?(state)
    @state == state
  end

  def thank(animal)
    animal # thank you!
  end

  def miserable
    has_pain?
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

class Lion < Animal
  def catch(animal)
    animal.is(:catched)
  end

  def release(animal)
    animal.is(:released)
  end

  def roar(opts={})
    talk "ROAAAR"
    if opts[:how] == :desparately
      talk "AYEE!"
    end
  end
end

class Mouse < Animal
  def plead(speech)
    talk speech
  end

  def help(animal)
    animal.attendants << self
  end

  def try_to_free(animal)
    if animal.is? :trapped
      r = Random.new
      if r.rand(0..10) == 10
        animal.is(:free)
      end
    end
  end
end
