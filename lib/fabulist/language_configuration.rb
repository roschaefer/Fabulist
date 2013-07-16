module Fabulist
  class LanguageConfiguration
    attr_accessor :language, :count_forwards, :count_backwards, :adress, :memorize, :i, :i_am

    def initialize
      self.language        = "English"
      self.count_forwards  = * "1st", "2nd", "3rd", "4th"
      self.count_backwards = * "last", "previous", "2nd_last", "3rd_last", "4th_last"
      self.adress          = * "the"
      self.memorize        = * "memorize"
      self.i               = * "i"
      self.i_am            = * "i_am"
    end

    def forwards
      self.count_forwards.map {|c| c.sub(/\d+/,'')}
    end

    def backwards
      self.count_backwards.map {|c| c.sub(/\d+/,'')}
    end
  end
end
