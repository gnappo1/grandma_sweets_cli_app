class Recipe
  attr_accessor :name, :description, :grade, :reviews, :ingridients, :ready_in_time, :instructions, :url, :history, :dose_for, :difficulty
  @@all = []

  def initialize
    self.class.all << self
    @favourites = []
  end

  def self.all
    @@all
  end

  def add_to_favourites
    @favourites << self
  end

  def favourites
    @favourites
  end
end
