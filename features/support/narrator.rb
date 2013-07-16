module Narrator
  define_method :i_am do |object|
    @narrator = object
  end

  [:i, :me].each do |method_name|
    define_method method_name do
      raise "Don't know, who I am?" if @narrator.nil?
      @narrator
    end
  end
end
World(Narrator)
