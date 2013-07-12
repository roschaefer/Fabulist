require "fabulist"

describe Fabulist do
  after(:each) do
    Fabulist.reset
  end

  it "complain, if he doesn't know what the narrator embodies" do
    expect{Fabulist.narrator}.to raise_error(RuntimeError, /Don't know who I am/)
  end

  it "returns the narrator, if specified beforehand" do
    Fabulist.narrator= "something"
    Fabulist.narrator.should eql("something")
    Fabulist.narrator.should be_kind_of(String)
  end

  describe ".configure" do
    it "evaluates the configuration block" do
      Fabulist.configure do |config|
        config.before_memorize = Proc.new { |model| "memorize" }
        config.after_recall    = Proc.new { |model| "recall" }
      end
      expect(Fabulist.configuration.before_memorize.call).to eq "memorize"
      expect(Fabulist.configuration.after_recall.call).to eq "recall"
    end

    it "assigns blocks to the configurations, if a block is given" do
      pending do
        Fabulist.configure do |config|
          config.before_memorize do |model|
            "memorize"
          end
          config.after_recall do |model|
            "recall"
          end
        end
        expect(Fabulist.configuration.before_memorize.call).to eq "memorize"
        expect(Fabulist.configuration.after_recall.call).to eq "recall"
      end
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
