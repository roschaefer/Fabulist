module Fabulist
  class Matcher
    def initialize(memory=nil, adapter=nil)
      @r = {}
      @memory = Fabulist.memory
    end

    def class_for_name(model_name)
      model_name.to_s.split('_').map!{ |w| w.capitalize }.join
    end

    def memory
      @memory ||= Memory.new
    end

    def adapter
      @adapter ||= Fabulist.configuration.adapter_instance
    end

    def model_names
      Fabulist.configuration.adapter_instance.model_names.join('|')
    end

    def counting_syllable
      %w(st nd rd th).join('|')
    end

  end

  class CreateNewMatcher < Fabulist::Matcher
    def method_missing(method_name, *args, &block)
      unless model_names.empty?
        if method_name =~ /^(#{model_names})$/
          create_a_model($1)
        else
          super
        end
      else
        super
      end
    end

    private
    def create_a_model(model_name)
      object = adapter.create(model_name)
      memory.append(object)
      object
    end

  end


  class AlreadyExistsMatcher < Matcher
    def initialize(index=1)
      super()
      @index = index
    end

    def method_missing(method_name, *args, &block)
      unless model_names.empty?
        if method_name =~ /^(#{model_names})$/
          Fabulist.memory.search_forwards(:class  => $1)
        else
          super
        end
      else
        super
      end
    end

  end
end

