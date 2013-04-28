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

end
