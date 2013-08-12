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

    def search_forwards(options={})
      search(@the_list, options)
    end

    def search_backwards(options={})
      search(@the_list.reverse, options)
    end

    private
    def search(list, opt={})
      index = opt[:index] || 1
      index -= 1
      result = list
      result = apply_class_check(result, opt[:class])
      result = apply_condition(result, opt[:condition], opt[:params])
      found  = result.at(index)
      raise NoObjectFound.new(self.the_list.size, opt) if found.nil?
      recalled = Fabulist.configuration.callbacks[:recall].call(found)
      recalled
    end

    def apply_condition(list, condition, args)
      unless condition.nil?
        list = list.select{|e| (e.respond_to? condition) && (e.__send__(condition, * args) == true) }
      end
      list
    end

    def apply_class_check(list, klass)
      begin
        constant = klass.to_s.camelize.constantize
        list.select{|e| e.kind_of? constant}
      rescue NameError
        list
      end
    end

    def camel_case(string)
      string.to_s.split('_').map{|e| e.capitalize}.join
    end
  end
end
