require 'fabulist'
  class ModelDecorator

    DELEGATED = [:is_a?, :kind_of?, :respond_to?, :class,
      :marshal_dump, :marshal_load,
      :freeze, :taint, :untaint, :trust, :untrust,
      :methods, :protected_methods, :public_methods,
      :object_id,
      :!, :!=, :==, :===, :eql?, :hash, :<=>,
      :dup, :clone, :inspect]

    DELEGATED.each do |delegated_method|
      define_method delegated_method do |*args|
        @model.send(*(args.unshift(delegated_method)))
      end
    end


    def initialize(model)
      @model = model
    end

    def method_missing(method, *args, &block)
      @model.send(method, *args, &block)
    end

  end

