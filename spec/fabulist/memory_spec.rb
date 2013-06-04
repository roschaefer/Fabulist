require 'spec_helper'
describe Fabulist::Memory do

  after(:each) do
    subject.clear
  end

  describe "#append" do
    it "should grow the list of tracked objects" do
      lambda do
        subject.append("A String")
      end.should change(subject.history, :size).by(1)
    end

    it "should notice the class names of the objects" do
      subject.append "A String"
      subject.append 12345
      subject.append /a Regex/
      subject.append Proc.new {}
      subject.append :symbol
      subject.append('and last but not least' => 'a Hash')
      subject.class_names.should include String
    end

    it "even with class names itselves" do
      subject.append String
      subject.class_names.should include(Class)
    end

  end
  describe "#search_backwards" do

    describe "should lookup the most recently created objects" do

      it "and return the last element, if no index given" do
        subject.append("A String")
        subject.append("Another String")
        subject.search_backwards.should eql("Another String")
        subject.search_backwards(:index  => 2).should eql("A String")
      end

      it "and raise an exception, if the search reached the beginning of history" do
        expect{subject.search_backwards()}.to raise_exception
      end

      it "and only count occurrences of the given class, if given" do
        subject.append("A String")
        subject.append(1)
        subject.search_backwards(:index  => 1, :class  => String).should eql("A String")
      end

      it "and raise an exception if there are less instances of the given class than the given index" do
        subject.append("A String")
        subject.append(1)
        expect{subject.search_backwards(:index  => 2, :class  => String)}.to raise_exception
      end

    end
  end
  describe "#search_forwards" do

    describe "should lookup elements the history in the order they were created" do

      it "and return the last element, if no index given" do
        subject.append("A String")
        subject.append("Another String")
        subject.search_forwards.should eql("A String")
        subject.search_forwards(:index  => 2).should eql("Another String")
      end

      it "and tries to call a condition on each element" do
        empty_string=""
        subject.append("Milkshake")
        subject.append(empty_string)
        subject.append("Hot Chocolate")
        subject.append("Coffee")
        subject.search_forwards(:condition => :empty?).should equal(empty_string)
      end

      it "and should not raise an error if the object does not understand the condition method" do
        subject.append("")
        subject.append(1)
        expect{subject.search_forwards(:index  => 1, :condition => :empty?)}.not_to raise_error
      end

      it "and just skips objects that doesn't understand the condition" do
        subject.append("")
        subject.append(1)
        subject.search_forwards(:condition => :empty?).should eql("")
      end

      it "and can pass params to the condition" do
        subject.append(1)
        subject.append(nil)
        subject.append("")
        subject.append("Yooho")
        subject.append("qwerty")
        subject.search_forwards({:condition => 'end_with?'}, 'ho').should eql("Yooho")
        subject.search_forwards({:class => Fixnum, :condition => '<'}, 5).should eql(1)
        subject.search_forwards({:condition => 'empty?'}).should eql("")
        # why does this fail?
        #subject.search_forwards(1, {:condition => 'nil?'}).should eql(nil)
        subject.search_forwards({:class => String, :condition => 'between?'}, 'qwert', 'qwertz').should eql("qwerty")
      end

    end
  end
end
