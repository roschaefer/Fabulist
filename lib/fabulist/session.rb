module Fabulist
  module Session
    def recall(klass=Object, method_name=nil, * args)
      Fabulist.memory.search(:class => klass, :condition => method_name, :params => args)
    end

    def memorize(object)
      Fabulist.memory.append object
    end
  end
end
