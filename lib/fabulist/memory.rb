module Fabulist
  class Memory

    attr_reader :the_list, :class_names

    def initialize
      self.clear
    end

    def clear
      @the_list = []
      @class_names = []
    end

    def size
      @the_list.size
    end

    def append(object)
      memorized = Fabulist.configuration.before_memorize.call(object)
      @the_list << memorized
      @class_names << object.class
    end

    def search_forwards(options={}, *args)
      search(@the_list, options, *args)
    end

    def search_backwards(options={}, *args)
      search(@the_list.reverse, options, *args)
    end

    private
    def search(list, opt={}, *args)
      index = opt[:index] || 1
      index -= 1
      result = list
      result = apply_class_check(result, opt[:class])
      result = apply_condition(result, opt[:condition], *args)
      found  = result.at(index)
      raise "No object found" if found.nil?
      recalled = Fabulist.configuration.after_recall.call(found)
      recalled
    end

    def apply_condition(list, condition, *args)
      unless condition.nil?
        list = list.select{|e| e.respond_to? condition and e.__send__(condition, *args)}
      end
      list
    end

    def apply_class_check(list, klass)
      unless klass.nil?
        list = list.select{|e| e.class.to_s == camel_case(klass)}
      end
      list
    end

    def camel_case(string)
      string.to_s.split('_').map{|e| e.capitalize}.join
    end
  end
end
