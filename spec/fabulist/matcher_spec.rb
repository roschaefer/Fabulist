require 'spec_helper'
describe Fabulist::CreateNewMatcher do

    it "should raise an exception, if can't recognize the model name" do
      matcher = Fabulist::CreateNewMatcher.new
      expect{matcher.unkown_model_name}.to raise_exception{NoMethodError}
    end

    it "should try to create a model if the method looks like a model" do
      user = mock
      Fabulist.configuration.adapter_instance.should_receive(:model_names).at_least(:once).and_return(['user'])
      Fabulist.configuration.adapter_instance.should_receive(:create).with('user').and_return(user)
      Fabulist.memory.should_receive(:append).with(user)
      matcher = Fabulist::CreateNewMatcher.new
      matcher.user
    end
end

