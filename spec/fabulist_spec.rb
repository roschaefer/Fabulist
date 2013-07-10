require "fabulist"

describe Fabulist do
  before(:each) do
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
    it "evaluates the configuration block in the Fabulist::Configuration scope" do
      scope = nil
      Fabulist.configure do
        scope = self
      end
      scope.should be_kind_of(Fabulist::Configuration)
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
