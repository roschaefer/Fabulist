class TaggedObject < BasicObject

  def initialize(model, opts = {})
    @features = opts
    @model = model
  end

  def method_missing(method, *args, &block)
    if @features.has_key?(method.to_sym)
      [args, args[0], true].any? {|value| value == @features[method.to_sym]}
    else
      @model.send(method, *args, &block)
    end
  end

  def respond_to?(method)
    @features.has_key?(method.to_sym) || @model.respond_to?(method)
  end
end
