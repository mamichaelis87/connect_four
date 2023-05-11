require_relative 'player.rb'

class Game 
  attr_accessor :board, :black, :white

  def initialize
    @board = [['  ', '  ', '  ', '  ', '  ', '  '],
              ['  ', '  ', '  ', '  ', '  ', '  '],
              ['  ', '  ', '  ', '  ', '  ', '  '],
              ['  ', '  ', '  ', '  ', '  ', '  '],
              ['  ', '  ', '  ', '  ', '  ', '  '],
              ['  ', '  ', '  ', '  ', '  ', '  '],
              ['  ', '  ', '  ', '  ', '  ', '  ']]
    @black = Player.new("one", "\u26ab")
    @white = Player.new("two", "\u26aa")
  end

  #runs game flow from start to finish
  def play_game
    turn_number = 0
    until connect_four
      display_board
      if turn_number >= 42 
        declare_tie
        break
      end
      take_turn
      turn_number += 1
    end
  end

  #determine who's turn it is and then makes a move for that person, 
  #and changes the turn tracker (@black.turn)
  def take_turn
    if @black.turn
      make_move(@black)
      @black.turn = false
    else
      make_move(@white)
      @black.turn = true
    end
  end

  #gets a move from the player
  def make_move(player)
    move = ask_for_move(player)
    update_board(move, player)
  end

  #update the board with selected move
  def update_board(move, player)
    row = @board[move].index('  ')
    @board[move][row] = player.symbol
  end

  #checks for and declares winner
  def connect_four
    if win_check(@black)
      display_board
      declare_winner(@black)
      true
    elsif win_check(@white)
      display_board
      declare_winner(@white)
      true
    else
      false
    end
  end

  def win_check(player)
    win = false
    #check columns
    if column_win(player)
      win = true
    end
    #check rows
    if row_win(player)
      win = true
    end
    #check diagonals
    if diagonal_win(player)
      win = true
    end

    return win
  end

  def column_win(player)
    counter = 0
    win = false
    @board.each do |column|
      if win
        break
      end
      column.each do |spot|
        if spot == player.symbol 
          counter += 1
        else 
          counter = 0
        end
        if counter >=4
          win = true
          break
        end
      end
    end 
    return win
  end

  def row_win(player)
    counter = 0
    win = false
    rows = [0, 1, 2, 3, 4, 5, 6]
    rows.each do |row|
      if win
        break
      end
      @board.each do |column|
        if column[row] == player.symbol
          counter += 1
        else 
          counter = 0
        end
        if counter >= 4
          win = true
          break
        end
      end
    end
    return win
  end

  def diagonal_win(player)
    diagonal_arrays = [[[0,3],[1,2],[2,1],[3,0]],
                       [[0,4],[1,3],[2,2],[3,1],[4,0]],
                       [[0,5],[1,4],[2,3],[3,2],[4,1],[5,0]],
                       [[1,5],[2,4],[3,3],[4,2],[5,1],[6,0]],
                       [[2,5],[3,4],[4,3],[5,2],[6,1]],
                       [[3,5],[4,4],[5,3],[6,2]],
                       [[0,2],[1,3],[2,4],[3,5]],
                       [[0,1],[1,2],[2,3],[3,4],[4,5]],
                       [[0,0],[1,1],[2,2],[3,3],[4,4],[5,5]],
                       [[1,0],[2,1],[3,2],[4,3],[5,4],[6,5]],
                       [[2,0],[3,1],[4,2],[5,3],[6,4]],
                       [[3,0],[4,1],[5,2],[6,3]]]
    counter = 0
    win = false
    diagonal_arrays.each do |diagonal|
      if win
        break
      end
      diagonal.each do |spot|
        if @board[spot[0]][spot[1]] == player.symbol
          counter += 1
        else
          counter = 0
        end
        if counter >= 4
          win = true
          break
        end
      end
    end
    return win
  end

  def intro
    puts "Welcome to connect four #{@black.name} and #{@white.name}!"
  end

  def display_board
    puts "|#{@board[0][5]}|#{@board[1][5]}|#{@board[2][5]}|#{@board[3][5]}|#{@board[4][5]}|#{@board[5][5]}|#{@board[6][5]}|"
    puts "|#{@board[0][4]}|#{@board[1][4]}|#{@board[2][4]}|#{@board[3][4]}|#{@board[4][4]}|#{@board[5][4]}|#{@board[6][4]}|"
    puts "|#{@board[0][3]}|#{@board[1][3]}|#{@board[2][3]}|#{@board[3][3]}|#{@board[4][3]}|#{@board[5][3]}|#{@board[6][3]}|"
    puts "|#{@board[0][2]}|#{@board[1][2]}|#{@board[2][2]}|#{@board[3][2]}|#{@board[4][2]}|#{@board[5][2]}|#{@board[6][2]}|"
    puts "|#{@board[0][1]}|#{@board[1][1]}|#{@board[2][1]}|#{@board[3][1]}|#{@board[4][1]}|#{@board[5][1]}|#{@board[6][1]}|"
    puts "|#{@board[0][0]}|#{@board[1][0]}|#{@board[2][0]}|#{@board[3][0]}|#{@board[4][0]}|#{@board[5][0]}|#{@board[6][0]}|"
    puts "|1 |2 |3 |4 |5 |6 |7 |"
  end

  def ask_for_move(player)
    puts "It's your turn #{player.name}, what is your move?"
    move = gets.chomp.to_i
    until valid_move(move)
      invalid_move
      move = gets.chomp.to_i
    end
    return move - 1
  end

  def valid_move(move)
    if move.between?(1, 7)
      true
    else
      false
    end
  end

  def declare_winner(player)
    puts "Congratulations #{player.name}, you won!"
  end

  def declare_tie
    puts "Looks like you two are too evenly matched."
  end

  def invalid_move
    puts "That move is not allowed, you must select a number between 1 and 7"
  end

end