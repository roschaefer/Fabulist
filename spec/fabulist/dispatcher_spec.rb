require 'spec_helper'

describe Fabulist::Dispatcher do
  let!(:memory) {Fabulist.memory}
  describe "#method_missing" do
    context "in case of a malformed method name" do
      it {expect{Fabulist::Dispatcher.new.any_malformed_method}.to raise_exception{NoMethodError}}
    end
    context "when there are models that sound similar, it" do

      subject do
        Fabulist::Dispatcher.new
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
        Fabulist::Dispatcher.new(2).nd_last_user
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

  #context "handles fabulist's native proxies" do
    #let!(:memory) {Fabulist.memory}

    #describe "#search" do
      #before(:all) do
        #memory.append Fabulist::ModelDecorator.new(nil, :called => "Mr Nil", :cool => true)
        #memory.append Fabulist::ModelDecorator.new(/regex/, :called => "Reg Ex", :cool  => true)
        #memory.append Fabulist::ModelDecorator.new('string', :called => "Plain String", :cool  => false)
        #memory.append Fabulist::ModelDecorator.new(3, :answer_to => "1+2 = ?")
        #memory.append Fabulist::ModelDecorator.new(42, :answer_to => "life, the universe and everything")
      #end

      #it "for tags" do
        #subject.answer_to("life, the universe and everything").should eq 42
      #end

      #it "for multiple tags" do
        #subject.cool(true).should be_an_instance_of NilClass
        #subject.cool(false).should be_an_instance_of String
        #subject.called("Reg Ex").should be_an_instance_of Regex
        #subject.called("Mr Nil").should be_nil
      #end

      #it "regards the proxies as their underlying object" do
        #Fabulist::Dispatcher.new(1).string.should eq "string"
        #Fabulist::Dispatcher.new(1).regex.should eq /regex/
        #Fabulist::Dispatcher.new(2).integer.should eq 42
      #end

      #it "calls the native methods of the object" do
        #subject.last_string.size.should eq 6
        #subject.string.should_not be_empty
      #end
    #end

  #end

end

