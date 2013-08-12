require "fabulist/version"
require "fabulist/memory"
require "fabulist/configuration"
module Fabulist

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
    @memory   = nil
    @config   = nil
    @narrator = nil
  end

end
