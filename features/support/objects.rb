class User
  attr_accessor :name

  def initialize(name)
    self.name = name
  end

  def called?(name)
    self.name == name
  end
end

class CoffeeMachine
  def has_left(number_of_coffees)
    @coffees = number_of_coffees
  end

  def has_coffees_left?
    @coffees > 0
  end

  def insert(amount)
    @money ||= 0
    @money += amount
  end

  def button
    ['b','u','t','t','o','n']
  end

  def has_served_a_coffee?(opts={})
    if (@money > 0) && opts[:to].tired?
      @coffees -= 1
      true
    end
  end
end

class Person
  def am_tired
    @tired = true
  end

  def tired?
    @tired
  end

  def interact(opts={})
    opts[:with].send(opts[:action], opts[:params])
  end

end
