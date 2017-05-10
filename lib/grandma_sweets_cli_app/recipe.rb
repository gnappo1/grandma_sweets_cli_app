class Recipe
  attr_accessor :name, :description, :grade, :reviews, :ingridients, :ready_in_time, :instructions, :url, :history, :dose_for, :difficulty
  @@all = []
  @@favourites = []

  def initialize
    self.class.all << self
  end

  def self.find(input_recipe)
    self.all[input_recipe.to_i-1]
  end

  def self.find_by(name)
    self.all.detect{|r| r.name.strip.downcase == name.strip.downcase}
  end

  def self.all
    @@all
  end

  def self.add_to_favourites(recipe)
    self.favourites << recipe unless !recipe.is_a?(Recipe) || self.favourites.include?(recipe)
  end

  def open_in_browser
    system("open '#{url}'")
  end

  def self.favourites
    @@favourites
  end

  def self.sort_by_review
    self.all.sort_by{|recipe| recipe.reviews.to_i}.reverse
  end
end
