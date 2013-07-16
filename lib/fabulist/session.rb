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

    Fabulist.language.i.each do |method|
      define_method method do
        Fabulist.narrator
      end
    end

    Fabulist.language.i_am.each do |method|
      define_method method do |narrator|
        Fabulist.narrator= narrator
      end
    end
  end
end
