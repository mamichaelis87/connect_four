class Player
  attr_reader :name, :symbol, :number
  attr_accessor :turn

  def initialize(number, symbol)
    @number = number
    @symbol = symbol
    @turn = true
    @name = get_name
  end

  def get_name
    puts "Player #{@number}, what is your name?"
    @name = gets.chomp
  end
end

# one = Player.new("one", "\u26ab")
# puts "Hello, #{one.name}. your symbol is #{one.symbol}"