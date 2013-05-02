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
      if klass.instance_of? String
        klass = constantize(class_for_name(klass))
      end
      list = list.select{|e| e.instance_of? klass}
    end
    list
  end


  def constantize(class_name)
    unless /\A(?:::)?([A-Z]\w*(?:::[A-Z]\w*)*)\z/ =~ class_name
      raise NameError, "#{class_name.inspect} is not a valid constant name!"
    end

    Object.module_eval("::#{$1}", __FILE__, __LINE__)
  end

  def class_for_name(model_name)
    model_name.to_s.split('_').map!{ |w| w.capitalize }.join
  end


  end


end


