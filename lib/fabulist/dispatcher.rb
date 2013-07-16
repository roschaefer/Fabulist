require 'active_support/inflector'
module Fabulist
  class Dispatcher

    def initialize(index = 1)
      @index = index
    end

    def method_missing(method_name, *args, &block)
      unless model_names.empty?
        if method_name =~ /^(?:#{backwards_regexp})_(#{model_names_regexp})_(#{feature_method})$/
          options = {:index  => @index, :class  => $1, :condition  => $2}
          options[:params] = args unless args.empty?
          Fabulist.memory.search_backwards(options)
        elsif method_name =~ /^(?:#{forwards_regexp})?_?(#{model_names_regexp})_(#{feature_method})$/
          options = {:index  => @index, :class  => $1, :condition  => $2}
          options[:params] = args unless args.empty?
          Fabulist.memory.search_forwards(options)
        elsif method_name =~ /^(?:#{backwards_regexp})_(#{model_names_regexp})$/
          Fabulist.memory.search_backwards(:index  => @index, :class  => $1)
        elsif method_name =~ /^(?:#{forwards_regexp})?_?(#{model_names_regexp})$/
          Fabulist.memory.search_forwards(:index  => @index, :class  => $1)
        elsif method_name =~ /^(?:#{backwards_regexp})$/
          Fabulist.memory.search_backwards(:index  => @index)
        elsif method_name =~ /^#{forwards_regexp}$/
          Fabulist.memory.search_forwards(:index  => @index)
        #elsif method_name =~ /^(?:#{counting_syllable})?_?(?:#{previous})_?(#{feature_method})$/
          #Fabulist.memory.search_backwards(:index  => @index, :condition => $1)
        elsif method_name =~ /^(?:#{forwards_regexp})?_?(#{feature_method})$/
          Fabulist.memory.search_forwards(:index  => @index, :condition => $1)
        else
          super
        end
      else
        super
      end
    end

    private
    def model_names_regexp
      model_names.join('|')
    end

    def model_names
      Fabulist.memory.class_names.map(&:to_s).map(&:underscore)
    end

    def forwards_regexp
      Fabulist.language_configuration.forwards.join('|')
    end

    def backwards_regexp
      Fabulist.language_configuration.backwards.join('|')
    end

    def feature_method
      ".+"
    end

  end

end
