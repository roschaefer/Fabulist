module Fabulist
  class Matcher
    def initialize(memory=nil, adapter=nil)
      @r = {}
      @memory = Fabulist.memory
      @adapter = Fabulist.configuration.adapter_instance
      @r[:any_model] = @adapter.model_names.join('|')
      @r[:counting_syllable] = %w(st nd rd th).join('|')
    end

    def memory
      @memory ||= Memory.new
    end

    def adapter
      @adapter ||= Fabulist.configuration.adapter_instance
    end
  end

  class CreateNewMatcher < Fabulist::Matcher
    def initialize
      super
    end
    def method_missing(method, *args, &block)
      unless @r[:any_model].empty?
        if method_name =~ /^(#{@r[:any_model]})$/
          object = adapter.create($1)
          memory.append(object)
          object
        else
          super
        end
      else
        super
      end
    end
  end


  class AlreadyExistsMatcher < Matcher
    def initialize(index=1)
      super()
      @index = index
    end

    def method_missing(method, *args, &block)
      if method_name =~ /^#{COUNTING_SYLLABLE}$/
        return memory.search_forwards(index)
      else
        super
      end
    end
  end
end

