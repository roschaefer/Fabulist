module Fabulist
  module Session
    def the(index=1)
      Dispatcher.new(index)
    end

    def memorize(object)
      Fabulist.memory.append object
    end
  end
end
