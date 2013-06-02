require 'fabulist'
module Fabulist
  class ModelDecorator < BasicObject

    def initialize(model)
      @model = model
    end

    def method_missing(method, *args, &block)
      @model.send(method, *args, &block)
    end

  end

end
