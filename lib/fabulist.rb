require "fabulist/version"
require "fabulist/matcher"
require "fabulist/model_decorator"

module Fabulist
  # ---------------------
  # NARRATOR
  # ---------------------
  def self.narrator
    raise StandardError, "Don't know, who I am!", caller if @narrator.nil?
    @narrator
  end

  def self.narrator=(model)
    @narrator = ModelDecorator.new(model)
  end

end
