require 'fabulist/matcher'
module Fabulist
  module Session

    def the(index=1)
      AlreadyExistsMatcher.new(index)
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
