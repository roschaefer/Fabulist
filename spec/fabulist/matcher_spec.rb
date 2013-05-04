require 'spec_helper'
describe Fabulist::CreateNewMatcher do
  subject {Fabulist::CreateNewMatcher.new}

  it "should raise an exception, if can't recognize the model name" do
    expect{subject.unkown_model_name}.to raise_exception{NoMethodError}
  end

  it "should try to create a model if the method looks like a model" do
    user = mock
    Fabulist.configuration.adapter_instance.should_receive(:model_names).at_least(:once).and_return(['user'])
    Fabulist.configuration.adapter_instance.should_receive(:create).with('user').and_return(user)
    Fabulist.memory.should_receive(:append).with(user)
    subject.user
  end
end

describe Fabulist::AlreadyExistsMatcher do
  let!(:adapter) {Fabulist.configuration.adapter_instance}
  let!(:memory) {Fabulist.memory}
  describe ".method_missing" do
    context "in case of a malformed method name" do
      it {expect{Fabulist::AlreadyExistsMatcher.new.any_malformed_method}.to raise_exception{NoMethodError}}
    end
    context "when there are models that sound similar, it" do

      before(:each) do
        adapter.stub(:model_names).and_return(['user','post','role'])
      end
      subject do
        Fabulist::AlreadyExistsMatcher.new
      end

      it "should search the memory" do
        memory.should_receive(:search_forwards).with(:index  => 1, :class  => 'user')
        subject.user
      end

      it "should search backwards in memory" do
        memory.should_receive(:search_backwards).with(:index  => 1, :class  => 'user')
        subject.last_user
      end

      it "should search backwards with an index" do
        memory.should_receive(:search_backwards).with(:index  => 2, :class  => 'user')
        Fabulist::AlreadyExistsMatcher.new(2).nd_last_user
      end

      it "should search for models that respond to certain method" do
        memory.should_receive(:search_forwards).with(:index  => 1, :class  => 'user', :condition  => 'who_is_happy')
        subject.user_who_is_happy
      end

      it "should search for models that respond to certain method with parameters" do
        memory.should_receive(:search_forwards).with(:index  => 1, :class  => 'user', :condition  => 'called', :params  => ['John'])
        subject.user_called('John')
      end

      it "should retrieve an instance of the model from the memory" do
        user = mock
        user.should_receive(:class).and_return('User')
        memory.append(user)
        subject.user.should equal(user)
      end
    end
  end
end

