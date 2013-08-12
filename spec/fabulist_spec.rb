require "fabulist"

describe Fabulist do
  after(:each) do
    Fabulist.reset
  end

  describe ".configure" do
    it "evaluates the configuration block" do
      Fabulist.configure do |config|
        config.before_memorize do |model|
          "memorize"
        end
        config.after_recall do |model|
          "recall"
        end
      end
      expect(Fabulist.configuration.callbacks[:memorize].call).to eq "memorize"
      expect(Fabulist.configuration.callbacks[:recall].call).to eq "recall"
    end
  end

  describe ".config" do
    it "returns the fabulist's configuration" do
      Fabulist.configure {}
      Fabulist.configuration.should be_kind_of(Fabulist::Configuration)
    end
  end

  describe ".memory" do
    it "returns the fabulist's memory" do
      Fabulist.memory.should be_kind_of(Fabulist::Memory)
    end
  end
end
