class Duck
  attr_accessor :grandchildren

  def initialize
    self.grandchildren = []
  end

  def grandchild_of?(duck)
    duck.grandchildren.include? self
  end

  def appear
    puts "Here I am"
  end

  def call(object)
    puts "Hey #{object}"
  end

  def to_s
    "Duck"
  end
end
