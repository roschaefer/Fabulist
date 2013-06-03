require "fabulist/proxy"
module Fabulist
  class Memory

    def initialize
      @list = []
    end

    def clear
      @list = []
    end

    def history
      @list
    end


    def append(object)
      @list << object
    end

    def search_forwards(options={}, *args)
      search(@list, options, *args)
    end

    def search_backwards(options={}, *args)
      search(@list.reverse, options, *args)
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


