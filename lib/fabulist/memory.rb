require "fabulist/model_decorator"
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

    def search_forwards(index=1, options={}, *args)
      search(@list, index, options, *args)
    end

    def search_backwards(index=1, options={}, *args)
      search(@list.reverse, index, options, *args)
    end

  private
  def search(list, index=1, opt={}, *args)
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
      list = list.select{|e| e.instance_of? klass}
    end
    list
  end

  end


end


