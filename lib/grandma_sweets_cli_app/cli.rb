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

  def list_recipes
    puts "Here's the list of our recipes:"
    @s.recipes.each.with_index(1) do |recipe, i|
      puts "-----------------------------------------------------"
      puts " #{(i).to_s} " + "#{recipe.name}"
      puts " "
      puts "     #{recipe.description}"
      puts "-----------------------------------------------------"
    end
  end


end
