class CLI

  def initialize
    puts "Welcome to GrandmaSweets Rubygem! Feel in the mood for some delicious recipes? Well, you're in the right place!!!\n".colorize(:color => :green)
    puts "Pick among our selection of traditional Italian recipes to impress your friends, and yourself!\n\n"
    puts "Loading recipes...\n\n".colorize(:color => :red)
    @s = Scraper.new
  end

  def call
    @s.scrape_recipes_page_1 && @s.scrape_recipes_page_2 && @s.scrape_recipes_page_3
    sleep 4
    list_recipes
    sleep 0.5
    meditation_pause
    select_recipe(input_recipe)
  end

  def list_recipes
    puts "Here's the list of our recipes:"
    @s.recipes.each.with_index(1) do |recipe, i|
      puts "-----------------------------------------------------".colorize(:color => :magenta)
      puts " #{(i).to_s}. " + "#{recipe.name}".colorize(:color => :green)
      puts " "
      puts "     #{recipe.description}"
      puts "-----------------------------------------------------".colorize(:color => :magenta)
    end
  end

  def meditation_pause
    puts "Press " + "'c'".colorize(:color => :green) + " when you feel ready to pick your recipe."
    input_continue = ""
    while input_continue != "c"
      input_continue = gets.strip.downcase
      if input_continue == "c"
        clear
        select_recipe(input_continue)
      else
        puts "Wrong input. Type " + "'c'".colorize(:color => :green) + " to continue."
      end
    end
  end

  def invalid_selection
    puts "Wrong input. Please type the " + " number ".colorize(:color => :yellow).bold + "of the recipe you're interested in, type " + "'back'".colorize(:color => :green).bold + " to list again all recipes or " + "'exit'".colorize(:color => :red).bold + " to exit"
  end

  def select_recipe(input_recipe)
    puts "So many delicious recipes... Which one would you like to try?\n\n"
    puts "Type the " + "number".colorize(:color => :yellow).bold + " corrisponding to the recipe you'd like to know more about, " + "'back'".colorize(:color => :green).bold + " to list the recipes again or " + "'exit'".colorize(:color => :red).bold + " to exit the program."
    input_recipe = ""
    while input_recipe != "exit" || input_recipe != "back"
      input_recipe = gets.strip.downcase
      case input_recipe
      when /\d+/
        ( invalid_selection; next;) unless input_recipe.to_i.between?(1,@s.recipes.length)
        read_recipe(input_recipe)
        open_in_browser?
        sleep 2
        add_recipe_to_favourites
        more_recipes
      when "back"
        clear
        list_recipes
        select_recipe(input_recipe)
      when "exit"
        goodbye
      else
        invalid_selection
      end
    end
  end

  def read_recipe(input_recipe)
    @recipe = Recipe.find(input_recipe)
    @s.scrape_recipe_details(@recipe)
    puts ""
    puts "___________________________________________   ".colorize(:color => :magenta) + " #{@recipe.name} ".upcase.colorize(:color => :yellow).bold + "   ________________________________________________".colorize(:color => :magenta)
    puts ""
    puts ""
    puts "Star rating:  #{@recipe.grade}/5 "
    puts "Recipe reviews:  #{@recipe.reviews} "
    puts ""
    puts "____________________________________________________________".colorize(:color => :magenta)
    puts "                        History                          \n ".colorize(:color => :yellow).bold
    puts " #{@recipe.history}"
    puts "____________________________________________________________".colorize(:color => :magenta)
    puts "                        Details                           \n".colorize(:color => :yellow).bold
    puts "Ready in:           #{@recipe.ready_in_time}"
    puts "Doses for:           #{@recipe.dose_for}"
    puts "Difficulty:           #{@recipe.difficulty}"
    puts "_____________________________________________________________".colorize(:color => :magenta)
    puts "                        Ingridients                      \n  ".colorize(:color => :yellow).bold
    puts "  #{@recipe.ingridients}"
    puts ""
    puts "_____________________________________________________________".colorize(:color => :magenta)
    puts "             Procedure, Curiosities and tips              \n ".colorize(:color => :yellow).bold
    puts ""
         @recipe.instructions.each {|p| puts " #{p}\n\n"}
    puts ""
    puts "______________________________________________________________________________________________________________________".colorize(:color => :magenta)
  end

  def open_in_browser?
    puts "Would you like to open the browser page of this recipe? Type " + "'y'".colorize(:color => :green) + " for yes and " + "'n'".colorize(:color => :red) + " for no."
    input_open = ""
    until input_open == "y" || input_open == "n"
      input_open = gets.strip.downcase
      case input_open
      when "y"
        @recipe.open_in_browser
      when "n"
        puts "Maybe some other time... There is some interesting info that you don't want to miss!"
      else
        puts "Wrong input. Please type Type " + "'y'".colorize(:color => :green) + " for yes and " + "'n'".colorize(:color => :red) + " for no."
      end
    end
  end


  def more_recipes
    puts "Would you like to see any other recipes? Type " + "'y'".colorize(:color => :green) + " for yes and " + "'n'".colorize(:color => :red) + " to exit the program."
    input_yes_no = ""
    until input_yes_no == "y" || input_yes_no == "n"
      input_yes_no = gets.strip.downcase
      case input_yes_no
      when "y"
        list_recipes
        select_recipe(input_yes_no)
      when "n"
        self.goodbye
      else
        puts "Wrong input. Please type Type " + "'y'".colorize(:color => :green) + " for yes and " + "'n'".colorize(:color => :red) + " to exit the program."
      end
    end
  end

  def add_recipe_to_favourites
    puts "Do you like this recipe? Would you like to save it in your " + "'Favorites List'".colorize(:color => :yellow).bold + " and display it?"
    puts "Type " + "'y'".colorize(:color => :green) + " for yes and " + "'n'".colorize(:color => :red) + " for no."
    input_yes_no = ""
    until input_yes_no == "y" || input_yes_no == "n"
      input_yes_no = gets.strip.downcase
      case input_yes_no
      when "y"
        puts "Recipe has been saved!".colorize(:color => :green)
        @recipe.class.add_to_favourites(@recipe)
        @recipe.class.favourites.each.with_index(1) do |recipe, i|
          puts "-----------------------------------------------------".colorize(:color => :magenta)
          puts " #{(i).to_s}. " + "#{recipe.name}".colorize(:color => :green)
          puts " "
          puts "     #{recipe.description}"
          puts "-----------------------------------------------------".colorize(:color => :magenta)
        end
      when "n"
        puts "Recipe hasn't been saved.".colorize(:color => :green)
      else
        puts "Wrong input. Please type Type " + "'y'".colorize(:color => :green) + " for yes and " + "'n'".colorize(:color => :red) + " for no."
      end
    end
  end


  def goodbye
    puts "Thank's for using this Gem, now it's time to get dirty and cook some " + "'Delicatesse'".italic + "!\n\n"
    puts "Hope to see you soon!".italic
    sleep 1
    exit
  end

  def clear
    system("clear")
  end
end
