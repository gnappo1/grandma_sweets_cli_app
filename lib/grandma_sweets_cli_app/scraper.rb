class Scraper

  def initialize
    @recipes = []
  end

  def recipes
    @recipes
  end

  def scrape_recipes_page_1
    Nokogiri::HTML(open("http://www.giallozafferano.it/ricette-cat/Dolci-e-Desserts/")).css("article").each do |r|
      recipe = Recipe.new
      recipe.name = r.css("h3 a").text
      recipe.description = r.css("p").text
      recipe.url = r.css("a").attr("href").value
      @recipes << recipe
    end
  end

  def scrape_recipes_page_2
    Nokogiri::HTML(open("http://www.giallozafferano.it/ricette-cat/page2/Dolci-e-Desserts/")).css("article").each do |r|
      recipe = Recipe.new
      recipe.name = r.css("h3 a").text
      recipe.description = r.css("p").text
      recipe.url = r.css("a").attr("href").value
      @recipes << recipe
    end
  end

  def scrape_recipes_page_3
    Nokogiri::HTML(open("http://www.giallozafferano.it/ricette-cat/page3/Dolci-e-Desserts/")).css("article").each do |r|
      recipe = Recipe.new
      recipe.name = r.css("h3 a").text
      recipe.description = r.css("p").text
      recipe.url = r.css("a").attr("href").value
      @recipes << recipe
    end
  end

  def scrape_recipes_page_4
    Nokogiri::HTML(open("http://www.giallozafferano.it/ricette-cat/page4/Dolci-e-Desserts/")).css("article").each do |r|
      recipe = Recipe.new
      recipe.name = r.css("h3 a").text
      recipe.description = r.css("p").text
      recipe.url = r.css("a").attr("href").value
      @recipes << recipe
    end
  end



  def scrape_recipe_details(recipe)
    recipe_page = Nokogiri::HTML(open(recipe.url))
    recipe.grade = recipe_page.css(".rating_panel").attr("data-content-rate").text
    recipe.reviews = recipe_page.css("article#content div.rating_rate").attr("title").text
    recipe.history = recipe_page.css(".intro p").text
    recipe.dose_for = recipe_page.css(".yield strong").text
    recipe.difficulty = recipe_page.css(".difficolta strong").text
    recipe.ingridients = recipe_page.css(".ingredienti .ingredient").text.gsub("\t", "").gsub("\n", " ")
    recipe.ready_in_time = recipe_page.css(".preptime strong").text
    recipe.instructions = recipe_page.css(".right-push > p:not([class])").collect {|p| p.text}.reject{|s| s.empty?}.reverse.drop(1).reverse
  end
end
