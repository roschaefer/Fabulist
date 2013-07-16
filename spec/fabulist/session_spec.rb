require 'spec_helper'
require 'fabulist/session'

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

  describe "#memorize" do
    it "stores a model in the memory" do
      expect {subject.memorize "Thing"}.to change{Fabulist.memory.size}.by(1)
    end
  end

  describe "#the" do
    it "returns a Dispatcher" do
      subject.the.should be_kind_of(Fabulist::Dispatcher)
    end
  end
end
