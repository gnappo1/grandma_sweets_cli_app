class Scraper

  def initialize
    @recipes = []
  end

  def recipes
    @recipes
  end

  def scrape_recipes
    Nokogiri::HTML(open("http://www.giallozafferano.it/ricette-cat/Dolci-e-Desserts/")).css("article").each do |r|
      recipe = Recipe.new
      recipe.name = r.css("h3 a").text
      recipe.description = r.css("p").text
      recipe.url = r.css("a").attr("href").value
      @recipes << recipe
    end
  end


end
