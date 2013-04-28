require 'fabulist/matcher'
module Fabulist
  module Session

    def the(index)
      AlreadyThereMatcher.new
    end

    def a_new
      CreateNewMatcher.new
    end

    def i
      Fabulist.narrator
    end

    def i_am(object)
      Fabulist.narrator= object
    end

  end
end
