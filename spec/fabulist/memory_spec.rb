require 'spec_helper'
describe Fabulist::Memory do

  after(:each) do
    subject.clear
    Fabulist.reset
  end

  describe "#append" do
    it "grows the list of tracked objects" do
      lambda do
        subject.append("A String")
      end.should change(subject, :size).by(1)
    end

    it "notices the class names of the objects" do
      subject.append "A String"
      subject.append 12345
      subject.append /a Regex/
      subject.append Proc.new {}
      subject.append :symbol
      subject.append('last but not least' => 'a Hash')
      subject.class_names.should include String
      subject.class_names.should include Proc
      subject.class_names.should include Fixnum
      subject.class_names.should include Regexp
      subject.class_names.should include Symbol
      subject.class_names.should include Hash
    end

    it "notices the class 'Class' of any class" do
      subject.append String
      subject.class_names.should include(Class)
    end

    it "notices the ancestors of the objects" do
      subject.append "A String"
      subject.class_names.should include String
      subject.class_names.should include Kernel
      subject.class_names.should include Object
      subject.class_names.should include BasicObject
    end

    it "does not store class name duplicates" do
      subject.append "Something"
      expect{subject.append "Something"}.not_to change{subject.class_names.count}
    end

    context "with a 'before memorize' hook" do
      before(:each) do
        Fabulist.configure do |config|
          config.callbacks[:memorize] = Proc.new do |model|
            model.save!
            model
          end
        end
      end

      it "#append executes the callback 'before_memorize'" do
        model = mock()
        model.should_receive(:save!).once
        subject.append model
      end
    end

    context "with a 'after recall' hook" do
      before(:each) do
        Fabulist.configure do |config|
          config.callbacks[:recall] = Proc.new do |model|
            model.there_you_are!
            model
          end
        end
      end

      it "#search_forwards executes the callback 'after recall'" do
        model = mock()
        model.should_receive(:there_you_are!).once
        subject.append model
        subject.search_forwards
      end

      it "#search_backwards executes the callback 'after recall'" do
        model = mock()
        model.should_receive(:there_you_are!).once
        subject.append model
        subject.search_backwards
      end
    end
  end

  describe "#search_backwards" do

    describe "lookup the most recently created objects" do

      it "returns the last element, if no index given" do
        subject.append("A String")
        subject.append("Another String")
        subject.search_backwards.should eql("Another String")
        subject.search_backwards(:index  => 2).should eql("A String")
      end

      it "raises an exception, if the search reached the beginning of history" do
        expect{subject.search_backwards()}.to raise_exception
      end

      it "only count occurrences of the given class, if given" do
        subject.append("A String")
        subject.append(1)
        subject.search_backwards(:index  => 1, :class  => String).should eql("A String")
      end

      it "raises an exception if there are less instances of the given class than the given index" do
        subject.append("A String")
        subject.append(1)
        expect{subject.search_backwards(:index  => 2, :class  => String)}.to raise_exception
      end

    end
  end
  describe "#search_forwards" do

    describe "lookup elements the history in the order they were created" do

      it "returns the last element, if no index given" do
        subject.append("A String")
        subject.append("Another String")
        subject.search_forwards.should eql("A String")
        subject.search_forwards(:index  => 2).should eql("Another String")
      end

      it "tries to call a condition on each element" do
        empty_string=""
        subject.append("Milkshake")
        subject.append(empty_string)
        subject.append("Hot Chocolate")
        subject.append("Coffee")
        subject.search_forwards(:condition => :empty?).should equal(empty_string)
      end

      it "trusts only elements, that return true as a value to the condition" do
        subject.append "true"
        expect{subject.index("rue")}.to raise_exception
        expect{ subject.search_backwards(:condition => :index, :params => "rue") }.to raise_exception
        subject.search_backwards(:condition => :end_with?, :params => "rue").should == "true"
      end

      it "should not raise an error if the object does not understand the condition method" do
        subject.append("")
        subject.append(1)
        expect{subject.search_forwards(:index  => 1, :condition => :empty?)}.not_to raise_error
      end

      it "just skips objects that doesn't understand the condition" do
        subject.append("")
        subject.append(1)
        subject.search_forwards(:condition => :empty?).should eql("")
      end

      it "can pass params to the condition" do
        subject.append(1)
        subject.append(nil)
        subject.append("")
        subject.append("Yooho")
        subject.append("qwerty")
        subject.search_forwards(:condition => 'end_with?', :params => ['ho']).should eql("Yooho")
        subject.search_forwards(:class => Fixnum, :condition => '<', :params => [5]).should eql(1)
        subject.search_forwards(:condition => 'empty?').should eql("")
        subject.search_forwards(:class => String, :condition => 'between?', :params => ['qwert', 'qwertz']).should eql("qwerty")
      end

      it "can search for nil" do
        pending do
          subject.append(nil)
          subject.search_forwards(:condition => 'nil?').should eql(nil)
        end
      end

    end
  end

  describe "::NoObjectFound Exception" do
      specify { expect{ subject.search_forwards(:condition => 'a_method') }.to raise_exception(Fabulist::Memory::NoObjectFound, /a_method/) }
      specify { expect{ subject.search_forwards(:class => String) }.to raise_exception(Fabulist::Memory::NoObjectFound, /String/) }
      specify { expect{ subject.search_forwards(:method => 'method', :params => ['one','two']) }.to raise_exception(Fabulist::Memory::NoObjectFound, /\["one", "two"\]/) }
  end
end
