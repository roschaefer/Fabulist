module Fabulist
  module Session
    Fabulist.language.get_dispatcher.each do |method|
      define_method method do |index=1|
        Dispatcher.new(index)
      end
    end

    Fabulist.language.append.each do |method|
      define_method method do |object|
        Fabulist.memory.append object
      end
    end
  end
end
