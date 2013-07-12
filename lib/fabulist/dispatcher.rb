require 'active_support/inflector'
module Fabulist
  class Dispatcher

    def initialize(index = 1)
      @index = index
    end

    def model_names
      Fabulist.memory.class_names.map(&:to_s).map(&:underscore).join('|')
    end

    def counting_syllable
      %w(st nd rd th).join('|')
    end

    def previous
      %w(last previous).join('|')
    end

    def feature_method
      '.*'
    end

    def method_missing(method_name, *args, &block)
      unless model_names.empty?
        if method_name =~ /^(?:#{counting_syllable})?_?(?:#{previous})_?(#{model_names})_(#{feature_method})$/
          options = {:index  => @index, :class  => $1, :condition  => $2}
          options[:params] = args unless args.empty?
          Fabulist.memory.search_backwards(options)
        elsif method_name =~ /^(?:#{counting_syllable})?_?(#{model_names})_(#{feature_method})$/
          options = {:index  => @index, :class  => $1, :condition  => $2}
          options[:params] = args unless args.empty?
          Fabulist.memory.search_forwards(options)
        elsif method_name =~ /^(?:#{counting_syllable})?_?(?:#{previous})_?(#{model_names})$/
          Fabulist.memory.search_backwards(:index  => @index, :class  => $1)
        elsif method_name =~ /^(?:#{counting_syllable})?_?(#{model_names})$/
          Fabulist.memory.search_forwards(:index  => @index, :class  => $1)
        elsif method_name =~ /^#{counting_syllable}$/
          Fabulist.memory.search_forwards(:index  => @index, :class  => $1)
        else
          super
        end
      else
        super
      end
    end
  end

end
