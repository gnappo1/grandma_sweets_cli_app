class CLI

  def initialize
    puts "Welcome to GrandmaSweets Rubygem! Feel in the mood for some delicious recipes? Well, you're in the right place!!!"
    puts "Pick among our selection of traditional Italian recipes to impress your friends, and yourself!"
    puts "Loading recipes..."
    @s = Scraper.new
  end

  def call
    @s.scrape_recipes
    sleep 4
    list_recipes
    sleep 2
    meditation_pause
    select_recipe
    goodbye
  end


end
