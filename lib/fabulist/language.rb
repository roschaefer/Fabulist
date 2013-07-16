module Fabulist
  class Language
    attr_accessor :i, :i_am
    attr_reader :get_dispatcher, :title, :append

    def initialize
      @title         = "English"
      count_forwards   "1st", "2nd", "3rd", "4th"
      count_backwards  "last", "2nd_last", "3rd_last", "4th_last"
      adress_sth       "the"
      memorize_sth     "memorize"
      self.i       = * "i"
      self.i_am    = * "i_am"
    end

    def forwards
      @forwards.map {|c| c.sub(/^\d+/,'')}
    end

    def backwards
      @backwards.map {|c| c.sub(/^\d+/,'')}
    end

    def to_s
      title
    end

    def adress_sth(*args)
      @get_dispatcher = args
    end

    def memorize_sth(*args)
      @append = args
    end

    def count_forwards(*args)
      @forwards = args
    end

    def count_backwards(*args)
      @backwards = args
    end
  end
end
