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

  def meditation_pause
    puts "Press 'c' when you feel ready to pick your recipe."
    input = gets.strip.downcase
    if input == "c"
      clear
      select_recipe
    else
      puts "Wrong input. Type 'c' to continue."
      meditation_pause
    end
  end

  def select_recipe
    puts "So many delicious recipes... Which one would you like to try?"
    puts "Type the number corrisponding to the recipe you'd like to know more about, 'back' to list the articles again or 'exit' to exit the program."
    input = ""
    while input != "exit" || input != "back"
      input = gets.strip.downcase
      clear
    end
  end


end
