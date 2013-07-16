require "fabulist/version"
require "fabulist/memory"
require "fabulist/configuration"
require "fabulist/language"
require "fabulist/dispatcher"

module Fabulist

  def self.configure(&block)
    @config = Fabulist::Configuration.new
    @config.instance_eval(&block)
  end

  def self.configuration
    @config ||= Fabulist::Configuration.new
    @config
  end

  def self.teach(title, &block)
    @lang_config = Fabulist::Language.new
    @lang_config.instance_eval(&block)
    @lang_config.title = title
  end

  def self.language
    @lang_config ||= Fabulist::Language.new
    @lang_config
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
