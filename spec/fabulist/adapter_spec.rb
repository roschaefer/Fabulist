require 'spec_helper'

describe Fabulist::Adapter do

  describe "#class_for_type" do
    it "should transform the type into a CamelCase Class" do
      subject.class_for_type(:user_session).should == 'UserSession'
    end
  end

  describe "#create" do
    it "should raise a NotImplementedError" do
      lambda do
        subject.create(:post, {})
      end.should raise_error(NotImplementedError)
    end
  end

end
