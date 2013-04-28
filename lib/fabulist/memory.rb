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

    def search(list, index=1, opt={})
      index -= 1
      if opt[:class].nil? and opt[:condition].nil?
        result = list.at(index)
      elsif opt[:class].nil?
        result = list.select{|e| e.respond_to? opt[:condition] and e.__send__ opt[:condition]}.at(index)
      elsif opt[:condition].nil?
        result = list.select{|e| e.instance_of? opt[:class]}.at(index)
      else
        result = list.select{|e| e.instance_of? opt[:class] and e.respond_to? opt[:condition] and e.__send__ opt[:condition]}.at(index)
      end
      raise "No object found" if result.nil?
      result
    end

    def search_forwards(index=1, options={})
      search(@list, index, options)
    end

    def search_backwards(index=1, options={})
      search(@list.reverse, index, options)
    end
  end

end


