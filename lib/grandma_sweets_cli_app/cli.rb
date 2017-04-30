class CLI

  def initialize
    puts "Welcome to GrandmaSweets Rubygem! Feel in the mood for some delicious recipes? Well, you're in the right place!!!"
    puts "Pick among our selection of traditional Italian recipes to impress your friends, and yourself!"
    puts "Loading recipes..."
    @s = Scraper.new
  end

  
end
