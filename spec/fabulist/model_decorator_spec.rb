require "fabulist"
require 'time'

describe Fabulist::ModelDecorator do
  context ".new" do
     context "defines every key value pair as a recognition method" do
       it "for Strings" do
         decorator = Fabulist::ModelDecorator.new(:called => "Joe")
         decorator.called("Joe").should be_true
         decorator.called("John").should be_false
       end

      it "for Times" do
        decorator = Fabulist::ModelDecorator.new(:taking_place => Time.parse("01.01.2020"))
        decorator.taking_place(Time.parse("1.1.2020")).should be_true
        decorator.taking_place(Time.parse("1.2.2020")).should be_false
      end
    end
  end

end

