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
      case input
        when /(\d+)/
          read_recipe(input)
          sleep 2
          add_recipe_to_favourites(input)
          more_recipes
        when "back"
          clear
          list_recipes
          select_recipe
        when "exit"
          goodbye
        else
          puts "Wrong input. Please type the number of the recipe you're interested in, type 'back' to list again all recipes or 'exit' to exit"
          input = gets.strip.downcase
      end
    end
  end

  def read_recipe(input)
    recipe = @s.recipes[input.to_i-1]
    @s.scrape_recipe_details(recipe)
    puts ""
    puts "____________________ #{recipe.name} ________________________"
    puts ""
    puts "Star rating:  #{recipe.grade}/5 "
    puts "Recipe reviews:  #{recipe.reviews} "
    puts ""
    puts "____________________________________________________________"
    puts "                        History                          \n "
    puts " #{recipe.history}"
    puts "____________________________________________________________"
    puts "                        Details                           \n"
    puts "Ready in:           #{recipe.ready_in_time}"
    puts "Doses for:           #{recipe.dose_for}"
    puts "Difficulty:           #{recipe.difficulty}"
    puts "_____________________________________________________________"
    puts "                        Ingridients                      \n  "
    puts "  #{recipe.ingridients}"
    puts ""
    puts "_____________________________________________________________"
    puts "             Procedure, Curiosities and tips              \n "
    puts ""
    puts "#{recipe.instructions}\n"
    puts ""
    puts "_____________________________________________________________"
  end

  def more_recipes
    puts "Would you like to see any other recipes? Type 'y' for yes and 'n' to exit the program."
    input = gets.strip.downcase
    if input == "y"
      list_recipes
      select_recipe
    elsif input == "n"
      self.goodbye
    else
      puts "Wrong input. Please type Type 'y' for yes and 'n' to exit the program."
    end
  end

  def add_recipe_to_favourites(input)
    recipe = @s.recipes[input.to_i-1]
    puts "Do you like this recipe? Would you like to save it in your 'Favorites List'?[y/n]"
    command = gets.strip.downcase
    if command == "y" || command == "yes"
      recipe.add_to_favourites
      "Recipe has been saved!"
    else
      "Recipe hasn't been saved."
    end
  end

  def goodbye
    puts "Thank's for using this Gem, now it's time to get dirty and cook some 'Delicatesse'!"
    puts "Hope to see you soon!"
    sleep 1
    exit
  end

end
