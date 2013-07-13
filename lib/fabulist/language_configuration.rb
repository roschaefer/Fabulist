module Fabulist
  class LanguageConfiguration
    attr_accessor :language, :count, :back, :adress, :memorize

    def initialize
      self.language = "English"
      self.narrator = "narrator"
      self.count    = * "1st", "2nd", "3rd", "4th"
      self.back     = * "last", "previous"
      self.adress   = * "the"
      self.memorize = * "memorize"
    end

    def counting_syllables
      self.count.map {|c| c.sub(/\d+/,'')}
    end
  end
end
