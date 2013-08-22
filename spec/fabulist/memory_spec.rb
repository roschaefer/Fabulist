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
        model = double()
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

      it "#search executes the callback 'after recall'" do
        model = double()
        model.should_receive(:there_you_are!).once
        subject.append model
        subject.search
      end

      it "#search executes the callback 'after recall'" do
        model = double()
        model.should_receive(:there_you_are!).once
        subject.append model
        subject.search
      end
    end
  end

  describe "#search" do

    it "raises an exception, if the search reached the beginning of history" do
      expect{subject.search()}.to raise_exception
    end

    it "only count occurrences of the given class, if given" do
      subject.append("A String")
      subject.append(1)
      subject.search(:index  => 1, :class  => String).should eql("A String")
    end

    it "raises an exception if there are less instances of the given class than the given index" do
      subject.append("A String")
      subject.append(1)
      expect{subject.search(:index  => 2, :class  => String)}.to raise_exception(Fabulist::Memory::NoObjectFound)
    end

    it "returns the last element, if no index given" do
      subject.append("Another String")
      subject.append("A String")
      subject.search.should eql("A String")
      subject.search(:index  => 2).should eql("Another String")
    end

    it "tries to call a condition on each element" do
      empty_string=""
      subject.append("Milkshake")
      subject.append(empty_string)
      subject.append("Hot Chocolate")
      subject.append("Coffee")
      subject.search(:condition => :empty?).should equal(empty_string)
    end

    it "trusts only elements, that return the value true when the condition method is invoked" do
      subject.append "true"
      expect{ subject.search(:condition => :index, :params => "rue") }.to raise_exception(Fabulist::Memory::NoObjectFound)
      subject.search(:condition => :end_with?, :params => "rue").should == "true"
    end

    it "just skips objects that don't understand the condition" do
      subject.append(1)
      subject.append("")
      subject.search(:condition => :empty?).should eql("")
    end

    it "can pass params to the condition" do
      subject.append(1)
      subject.append(nil)
      subject.append("")
      subject.append("Yooho")
      subject.append("qwerty")
      subject.search(:condition => 'end_with?', :params => ['ho']).should eql("Yooho")
      subject.search(:class => Fixnum, :condition => '<', :params => [5]).should eql(1)
      subject.search(:condition => 'empty?').should eql("")
      subject.search(:class => String, :condition => 'between?', :params => ['qwert', 'qwertz']).should eql("qwerty")
    end

    it "can search for nil" do
      subject.append(nil)
      subject.search(:condition => 'nil?').should eql(nil)
    end
  end

  describe "::NoObjectFound Exception" do
    specify { expect{ subject.search(:condition => 'a_method') }.to raise_exception(Fabulist::Memory::NoObjectFound, /a_method/) }
    specify { expect{ subject.search(:class => String) }.to raise_exception(Fabulist::Memory::NoObjectFound, /String/) }
    specify { expect{ subject.search(:method => 'method', :params => ['one','two']) }.to raise_exception(Fabulist::Memory::NoObjectFound, /\["one", "two"\]/) }
  end
end
