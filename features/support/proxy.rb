class Proxy < BasicObject

  def initialize(model, opts = {})
    @features = opts
    @model = model
  end

  def method_missing(method, *args, &block)
    if @features.has_key?(method.to_sym)
      @features[method.to_sym] == args || @features[method.to_sym] == args[0]
    elsif @features.has_key?(method)
      @features[method] == args || @features[method] == args[0]
    else
      @model.send(method, *args, &block)
    end
  end

  def respond_to?(method)
    @features.has_key?(method.to_sym) || @features.has_key?(method.to_sym) || @model.respond_to?(method)
  end
end
