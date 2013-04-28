module Fabulist
  class Matcher
    def initialize
      @configuration = Fabulist.configuration
      @memory = Fabulist.memory
      @adapter = @configuration.adapter
      @model_name = @adapter.model_names.join('|')
      counting_syllable = %w(st nd rd th).join('|')
    end

  end

  class CreateNewMatcher < Matcher
    def method_missing(method, *args, &block)
      if method_name =~ /^(#{@model_name})$/
        object = @adapter.create($1)
        @memory.append(object)
      else
        super
      end
    end
  end


  class AlreadyExistsMatcher < Matcher
    def intialize(index)
      super
      @index = index
    end

    def method_missing(method, *args, &block)
      if method_name =~ /^#{COUNTING_SYLLABLE}$/
        return memory.search_forwards
      else
        super
      end
    end
  end
end

