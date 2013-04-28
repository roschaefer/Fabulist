require "fabulist"
describe Fabulist do
  it "should complain, if he doesn't know what the narrator embodies" do
    expect{ Fabulist.narrator }.to raise_error
  end

  it "should return the narrator, if specified beforehand" do
    Fabulist.narrator= "something"
    Fabulist.narrator.should eql("something")
    Fabulist.narrator.should be_kind_of(String)
  end

  describe ".configure" do
    it "should eval the configuration block in the Fabulist::Configuration scope" do
      scope = nil
      Fabulist.configure do
        scope = self
      end
      scope.should be_kind_of(Fabulist::Configuration)
    end
  end

  describe ".config" do
    it "should return a Fabulist::Configuration" do
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
