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
      klass, condition, args  = opt[:class], opt[:condition], opt[:params]
      unless klass.nil?
        result = result.select{|e| e.kind_of? klass}
      end
      unless condition.nil?
        result = result.select{|e| (e.respond_to? condition) && (e.__send__(condition, * args) == true) }
      end
      raise NoObjectFound.new(self.the_list.size, opt) if result.size == index
      found  = result.at(index)
      Fabulist.configuration.callbacks[:recall].call(found)
    end
  end
end
