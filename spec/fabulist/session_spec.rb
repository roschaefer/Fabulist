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

  describe "#a_new" do
    it "should return a CreateNewMatcher" do
      subject.a_new.should be_kind_of(Fabulist::CreateNewMatcher)
    end
  end
end
