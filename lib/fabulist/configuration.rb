module Fabulist
  class Configuration
    attr_reader :callbacks

    def initialize
      @callbacks = {}
      @callbacks[:memorize] = Proc.new do |model|
        model
      end

      @callbacks[:recall] = Proc.new do |model|
        model
      end
    end

    def before_memorize(&block)
      @callbacks[:memorize] = block
    end

    def after_recall(&block)
      @callbacks[:recall] = block
    end

  end
end
