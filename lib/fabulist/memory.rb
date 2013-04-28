module Fabulist
  class Memory

    def initialize
      @list = []
    end


    def append(object)
      @list << object
    end

    def search_forwards(index=1, klass=nil, condition=nil)
      if klass.nil? and condition.nil?
        return @list.at(index)
      elsif klass.nil?
        raise NotImplementedError
      elsif condition.nil?
        raise NotImplementedError
      else
        raise NotImplementedError
      end
    end

    def search_backwards(index=1, klass=nil, condition=nil)
      if klass.nil? and condition.nil?
        return @list.reverse.at(index)
      elsif klass.nil?
        raise NotImplementedError
      elsif condition.nil?
        raise NotImplementedError
      else
        raise NotImplementedError
      end
    end
  end

end


