module Fabulist
  class Configuration
    attr_accessor :before_memorize, :after_recall

    def initialize
      self.before_memorize = Proc.new do |model|
        model
      end

      self.after_recall = Proc.new do |model|
        model
      end
    end
  end
end
