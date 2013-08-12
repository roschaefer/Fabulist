module Fabulist
  class Dispatcher

    def initialize(index = 1)
      @index = index
    end

    def method_missing(method_name, *args, &block)
      if method_name =~ /^(?:#{backwards_regexp})_(#{class_names_regexp})_(#{feature_method})$/
        options = {:index  => @index, :class  => $1, :condition  => $2}
        options[:params] = args unless args.empty?
        Fabulist.memory.search_backwards(options)
      elsif method_name =~ /^(?:#{forwards_regexp})?_?(#{class_names_regexp})_(#{feature_method})$/
        options = {:index  => @index, :class  => $1, :condition  => $2}
        options[:params] = args unless args.empty?
        Fabulist.memory.search_forwards(options)
      elsif method_name =~ /^(?:#{backwards_regexp})_(#{class_names_regexp})$/
        Fabulist.memory.search_backwards(:index  => @index, :class  => $1)
      elsif method_name =~ /^(?:#{forwards_regexp})?_?(#{class_names_regexp})$/
        Fabulist.memory.search_forwards(:index  => @index, :class  => $1)
      elsif method_name =~ /^(?:#{backwards_regexp})$/
        Fabulist.memory.search_backwards(:index  => @index)
      elsif method_name =~ /^(?:#{forwards_regexp})$/
        Fabulist.memory.search_forwards(:index  => @index)
      elsif method_name =~ /^(?:#{backwards_regexp})_(#{feature_method})$/
        Fabulist.memory.search_backwards(:index  => @index, :condition => $1)
      elsif method_name =~ /^(?:#{forwards_regexp})?_?(#{feature_method})$/
        Fabulist.memory.search_forwards(:index  => @index, :condition => $1)
      else
        super
      end
    end

    private
    def class_names_regexp
      class_names.join('|')
    end

    def class_names
      Fabulist.memory.class_names.map(&:to_s).map(&:underscore)
    end

    def forwards_regexp
     ["st", "nd", "rd", "th"].join('|')
    end

    def backwards_regexp
     ["last", "st_last", "nd_last", "rd_last", "th_last"].join('|')
    end

    def feature_method
      ".+"
    end

  end

end
