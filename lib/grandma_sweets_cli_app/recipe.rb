class Recipe
  attr_accessor :name, :description, :grade, :reviews, :ingridients, :ready_in_time, :instructions, :url, :history, :dose_for, :difficulty
  @@all = []
  @@favourites = []

  def initialize
    self.class.all << self
  end

  def self.all
    @@all
  end

  def self.add_to_favourites(recipe)
    self.favourites << recipe unless !recipe.is_a?(Recipe)
  end

  def self.favourites
    @@favourites
  end
end
