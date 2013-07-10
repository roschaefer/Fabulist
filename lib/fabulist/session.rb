require 'fabulist/dispatcher'
module Fabulist
  module Session

    def the(index=1)
      Dispatcher.new(index)
    end

    def memorize(model)
      Fabulist.memory.append model
    end

    def i
      Fabulist.narrator
    end

    def i_am(object)
      Fabulist.narrator= object
    end
  end
end
