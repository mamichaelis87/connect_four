require_relative '../lib/game.rb'
require_relative '../lib/player.rb'

describe Game do
  describe '#initialize' do
    #no test needed, just variable initialization
  end

  describe '#play_game' do
    #no test needed, just function calls
  end

  describe '#take_turn' do
    #no test needed, just function calls
  end

  describe '#make_move' do
    #no test needed, just function calls
  end

  describe '#update_board' do
    #test that board is changed in correct spot
    subject(:game) {described_class.new}

    context 'when black player selects 7' do
      before do
        allow(game.black).to receive(:get_name).and_return("Bob")
      end
      it 'changes the bottom of column 7 (really 6) to black' do
        game.update_board(6, game.black)
        result = game.board[6][0]
        expect(result).to eq("\u26ab")
      end
    end

    context 'when white player selects 3' do
      before do
        allow(game.white).to receive(:get_name).and_return("Sally")
      end
      it 'changes the bottom of column 3 (really 2) to white' do
        game.update_board(2, game.white)
        result = game.board[2][0]
        expect(result).to eq("\u26aa")
      end
    end
  end
  describe '#connect_four' do
    #no test needed, just function calls
  end

  describe '#win_check' do
    #no test needed, just function calls
  end

  describe '#column_win' do
    subject(:game) {described_class.new}
    #test that returns true when there is a column win
    context 'when column 4 has 4 consecutive black pieces vertically' do
      before do
        game.board =  
        [['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ["\u26ab", '  ', "\u26ab", "\u26ab", "\u26ab", "\u26ab"],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  ']]
      end
      it 'returns true (win)' do
        result = game.column_win(game.black)
        expect(result).to be true
      end
    end
    #test that returns false when there is not a column win
    context 'when there is not 4 consecutive black pieces in any column' do
      before do
        game.board =  
        [['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ["\u26ab", '  ', "\u26ab", '  ', "\u26ab", "\u26ab"],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  ']]
      end
      it 'returns false (not win)' do
        result = game.column_win(game.black)
        expect(result).to be false
      end
    end 
  end

  describe '#row_win' do
    #test that returns true when there is a row win
    subject(:game) {described_class.new}
    context 'when row 3 has 4 consecutive white pieces' do
      before do
        game.board = 
        [['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', "\u26aa", '  ', '  ', '  '],
        ['  ', '  ', "\u26aa", '  ', '  ', '  '],
        ['  ', '  ', "\u26aa", '  ', '  ', '  '],
        ['  ', '  ', "\u26aa", '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  ']]
      end
      it 'returns true (win)' do
        result = game.row_win(game.white)
        expect(result).to be true
      end
    end
    #test that returns false when there is not a row win
    context 'when no row has 4 consecutive white pieces' do
      before do
        game.board = 
        [['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  ']]
      end
      it 'returns false (not a win)' do
        result = game.row_win(game.white)
        expect(result).to be false
      end
    end
  end

  describe '#diagonal_win' do
    subject(:game) {described_class.new}
    #test that returns true when there is a diagonal win (both inclining and declining)
    context 'when there is four consecutive black pieces diagonally (incline)' do
      before do
        game.board = 
        [['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', "\u26ab", '  ', '  ', '  ', '  '],
        ['  ', '  ', "\u26ab", '  ', '  ', '  '],
        ['  ', '  ', '  ', "\u26ab", '  ', '  '],
        ['  ', '  ', '  ', '  ', "\u26ab", '  '],
        ['  ', '  ', '  ', '  ', '  ', '  ']]
      end
      it 'returns true (win)' do
        result = game.diagonal_win(game.black)
        expect(result).to be true
      end
    end

    context 'when there is four consecutive black pieces diagonally (decline)' do
      before do
        game.board = 
        [['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', "\u26ab", '  ', "\u26ab", '  ', '  '],
        ['  ', '  ', "\u26ab", '  ', '  ', '  '],
        ['  ', "\u26ab", '  ', '  ', '  ', '  '],
        ["\u26ab", '  ', '  ', '  ', "\u26ab", '  '],
        ['  ', '  ', '  ', '  ', '  ', '  ']]
      end
      it 'returns true (win)' do
        result = game.diagonal_win(game.black)
        expect(result).to be true
      end
    end
    #test that returns false when there is not a diagonal win
    context 'when no diagonal four in a row exists' do
      before do
        game.board = 
        [['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  '],
        ['  ', '  ', '  ', '  ', '  ', '  ']]
      end
      it 'returns false (not win)' do
        result = game.diagonal_win(game.black)
        expect(result).to be false
      end
    end
  end

  describe '#intro' do
    # no tests needed for puts
  end

  describe '#display_board' do 
    #no test needed for puts
  end

  describe '#ask_for_move' do
    # no tests needed for puts and gets
  end 

  describe '#valid_move' do
    #test that 4 returns true
    #test that -1 returns false
    #test that 8 returns false
    #test that a non-number entry returns false
  end

  describe '#declare_winner' do
    # no tests needed for puts
  end

  describe '#declare_tie' do
    # no tests needed for puts
  end

  describe '#invalid_move' do
    # no tests needed for puts
  end
end