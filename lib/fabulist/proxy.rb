require 'fabulist'
module Fabulist
  class Proxy < BasicObject

    def initialize(model, opts = {})
      @features = opts
      opts.each_pair do |key, value|
        Proxy.define_method key do |aValue|
          @features[key] == aValue
        end
      end
      @model = model
    end

    def method_missing(method, *args, &block)
      @model.send(method, *args, &block)
    end

    def respond_to?(method)
      @features.has_key?(method) || @model.respond_to?(method)
    end

  end
end
