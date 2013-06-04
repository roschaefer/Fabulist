require "fabulist/proxy"
module Fabulist
  class Memory

    attr_reader :history, :class_names

    def initialize
      self.clear
    end

    def clear
      @history = []
      @class_names = []
    end

    def append(object)
      @history << object
      @class_names << object.class
    end

    def search_forwards(options={}, *args)
      search(@history, options, *args)
    end

    def search_backwards(options={}, *args)
      search(@history.reverse, options, *args)
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
    found
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


