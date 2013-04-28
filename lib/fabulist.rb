require "fabulist/version"
require "fabulist/memory"
require "fabulist/configuration"
require "fabulist/session"
require "fabulist/adapter"

module Fabulist
  # ---------------------
  # NARRATOR
  # ---------------------
  def self.narrator
    raise "Don't know who I am!" if @narrator.nil?
    @narrator
  end

  def self.narrator=(model)
    @narrator = ModelDecorator.new(model)
  end

  def self.configure(&block)
    @config = Fabulist::Configuration.new
    @config.instance_eval(&block)
  end

  def self.configuration
    @config ||= Fabulist::Configuration.new
    @config
  end

  def self.memory
    @memory ||= Fabulist::Memory.new
    @memory
  end

  def self.reset
    @memory = nil
    @configuration = nil
    @narrator = nil
  end

end
