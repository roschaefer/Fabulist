require 'spec_helper'
describe Fabulist::CreateNewMatcher do
  before(:each) do
    @matcher = Fabulist::CreateNewMatcher.new
  end
    it "should raise an exception, if can't recognize the model name" do
      expect{@matcher.unkown_model_name}.to raise_exception{NoMethodError}
    end
end

