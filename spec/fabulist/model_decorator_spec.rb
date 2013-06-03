require "fabulist"
require 'spec_helper'
require 'time'

describe Fabulist::ModelDecorator do
  context ".new" do
     context "defines every key value pair as a recognition method" do
       it "for Strings" do
         user = "A User"
         decorator = Fabulist::ModelDecorator.new(user, :called => "Joe")
         decorator.called("Joe").should be_true
         decorator.called("John").should be_false
       end

      it "for Times" do
        match = "A Match"
        decorator = Fabulist::ModelDecorator.new(match, :taking_place => Time.parse("01.01.2020"))
        decorator.taking_place(Time.parse("1.1.2020")).should be_true
        decorator.taking_place(Time.parse("1.2.2020")).should be_false
      end

      it "and responds to it" do
        match = "A Match"
        decorator = Fabulist::ModelDecorator.new(match, :taking_place => Time.parse("01.01.2020"))
        decorator.should respond_to(:taking_place)
        decorator.should_not respond_to(:something_else)
      end

      it "even multiple times" do
        match = "A Match"; user1 = "First user"; user2 = "Second user"
        decorator = Fabulist::ModelDecorator.new(match, :participants => [user1, user2], :taking_place => Time.parse("01.01.2020"))
        decorator.taking_place(Time.parse("1.1.2020")).should be_true
        decorator.taking_place(Time.parse("1.2.2020")).should be_false
        decorator.participants([user1, user2]).should be_true
        decorator.participants(user1).should be_false
        decorator.participants([user1]).should be_false
      end
    end
  end

end

