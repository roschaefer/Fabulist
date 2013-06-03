require 'spec_helper'

describe Fabulist::Session do

  before(:each) do
    Fabulist.reset
  end

  subject do
    sessionClass = Class.new do
      include Fabulist::Session
    end
    session = sessionClass.new
    session
  end

  describe "#i" do

    it "should return the narrator, if already set" do
      subject.i_am "somebody"
      subject.i.should be_equal(Fabulist.narrator)
    end

    it "should complain, if he doesn't know what the narrator embodies" do
      expect{subject.i}.to raise_error(RuntimeError, /Don't know who I am/)
    end
  end

  describe "#remember" do
    it "should store a model in the memory" do
      expect {subject.remember "Thing"}.to change{Fabulist.memory.history.size}.by(1)
    end
  end

  describe "#the" do
    it "should return a Dispatcher" do
      subject.the.should be_kind_of(Fabulist::Dispatcher)
    end
  end
end
