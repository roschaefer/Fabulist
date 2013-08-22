module Fabulist
  class Memory
    class NoObjectFound < StandardError
      def initialize(list_size, options)
        msg = "\nCurrent memory size is #{list_size}\n"
        options.each {|key_value| msg << key_value.to_s << "\n" }
        super(msg)
      end
    end

    attr_reader :the_list

    def initialize
      self.clear
    end

    def clear
      @the_list = []
    end

    def size
      @the_list.size
    end

    def append(object)
      memorized = Fabulist.configuration.callbacks[:memorize].call(object)
      @the_list << memorized
    end

    def search(opt={})
      index = opt[:index] || 1
      index -= 1
      result = @the_list.reverse
      result = apply_class_check(result, opt[:class])
      result = apply_condition(result, opt[:condition], opt[:params])
      raise NoObjectFound.new(self.the_list.size, opt) if result.size == index
      found  = result.at(index)
      recalled = Fabulist.configuration.callbacks[:recall].call(found)
      recalled
    end

    private
    def apply_condition(list, condition, args)
      unless condition.nil?
        list = list.select{|e| (e.respond_to? condition) && (e.__send__(condition, * args) == true) }
      end
      list
    end

    def apply_class_check(list, klass)
      unless klass.nil?
        list = list.select{|e| e.kind_of? klass}
      end
      list
    end
  end
end
