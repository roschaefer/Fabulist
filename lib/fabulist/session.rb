module Fabulist
  module Session


    def the(index)
      Fabulist::Matcher::AlreadyThereMatcher.new
    end

    def a_new
      Fabulist::Matcher::CreateNewMatcher.new
    end

    def i

    end

  end
end
