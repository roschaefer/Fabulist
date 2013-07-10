require 'spec_helper'
require 'pry'

describe Fabulist::Dispatcher do
  let!(:memory) {Fabulist.memory}
  describe "#method_missing" do
    context "in case of a malformed method name" do
      it {expect{described_class.new.any_malformed_method}.to raise_exception{NoMethodError}}
    end
    context "when there are models that sound similar, it" do
      before(:each) do
        memory.stub(:class_names).and_return(["User"])
      end

      subject { described_class.new }
      it "search the memory" do
        memory.should_receive(:search_forwards).with(:index  => 1, :class  => 'user')
        subject.user
      end

      it "search backwards in memory" do
        memory.should_receive(:search_backwards).with(:index  => 1, :class  => 'user')
        subject.last_user
      end

      it "search backwards with an index" do
        memory.should_receive(:search_backwards).with(:index  => 2, :class  => 'user')
        described_class.new(2).nd_last_user
      end

      it "search for models that respond to certain method" do
        memory.should_receive(:search_forwards).with(:index  => 1, :class  => 'user', :condition  => 'who_is_happy')
        subject.user_who_is_happy
      end

      it "search for models that respond to certain method with parameters" do
        memory.should_receive(:search_forwards).with(:index  => 1, :class  => 'user', :condition  => 'called', :params  => ['John'])
        subject.user_called('John')
      end

      it "retrieve an instance of the model from the memory" do
        user = mock
        user.should_receive(:class).exactly(2).times.and_return('User')
        memory.append(user)
        subject.user.should equal(user) # here goes the second call to user.class
      end
    end
  end

  it "asks the memory for a list of class names" do
    memory.should_receive(:class_names).and_return([String, Integer, Symbol])
    expect {subject.something}.to raise_exception{NoMethodError}
  end

end

