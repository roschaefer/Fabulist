module Fabulist
  module Session
    Fabulist.language_configuration.adress_sth.each do |method|
      define_method method do |index=1|
        Dispatcher.new(index)
      end
    end

    Fabulist.language_configuration.memorize_sth.each do |method|
      define_method method do |object|
        Fabulist.memory.append object
      end
    end

    Fabulist.language_configuration.i.each do |method|
      define_method method do
        Fabulist.narrator
      end
    end

    Fabulist.language_configuration.i_am.each do |method|
      define_method method do |narrator|
        Fabulist.narrator= narrator
      end
    end
  end
end
