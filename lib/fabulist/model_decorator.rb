require 'fabulist'
module Fabulist
  class ModelDecorator < BasicObject

    def initialize(model, opts = {})
      @identifiers = opts
      opts.each_pair do |key, value|
        ModelDecorator.define_method key do |aValue|
          @identifiers[key] == aValue
        end
      end
      @model = model
    end

    def method_missing(method, *args, &block)
      @model.send(method, *args, &block)
    end

    def respond_to?(method)
      @identifiers.has_key?(method) || @model.respond_to?(method)
    end

  end
end
