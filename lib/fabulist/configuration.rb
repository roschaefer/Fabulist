module Fabulist
  class Configuration

    attr_reader :adapter

    def initialize
      @model_configuration ||= {}
      @adapter ||= :factory_girl
    end

    def use_adapter(adapter)
      @adapter = adapter
    end

    def adapter
      @adapter ||= adapter_klass.new
    end

    def adapter_klass
      adapter_name = adapter.to_s.split('_').map!{ |w| w.capitalize }.join
      adapter_class = "Fabulist::Adapter::#{adapter_name}"
      unless eval("defined?(#{adapter_class}) && #{adapter_class}.is_a?(Class)") == true
        require File.join('fabulist', 'adapter', "#{adapter}")
      end
      eval adapter_class
    end
    private :adapter_klass

  end
end
