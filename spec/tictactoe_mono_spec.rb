require_relative '../tictactoe_mono'

RSpec.describe Player do
  describe '#symbol' do
    it 'returns the symbol' do
      player = Player.new('Player 1', 'X')
      expect(player.symbol).to eq('X')
    end
  end
end

RSpec.describe Board do
  describe '#full?' do
    context 'when the board is full' do
      it 'returns true' do
        board = Board.new
        3.times do |row|
          3.times { |col| board.place_symbol(row, col, 'X') }
        end
        expect(board.full?).to be true
      end

      context 'when the board is not full' do
        it 'returns false' do
          board = Board.new
          # Fill the board partially
          board.place_symbol(0, 0, 'X')
          board.place_symbol(0, 1, 'O')
          board.place_symbol(0, 2, 'X')
          board.place_symbol(1, 0, 'O')
          board.place_symbol(1, 1, 'X')
          board.place_symbol(1, 2, 'O')
          board.place_symbol(2, 0, 'X')
          board.place_symbol(2, 1, 'O')
          # Leave at least one cell empty
          # In this case, cell (2, 2) is left empty

          expect(board.full?).to be false
        end
      end
    end
  end

  describe '#place_symbol' do
    it 'places the symbol on the board' do
      board = Board.new
      expect(board.place_symbol(0, 0, 'X')).to be true

      # Verify that the symbol is placed correctly
      board_state = board.instance_variable_get(:@board)
      expect(board_state[0][0]).to eq('X')
    end

    it 'returns false for an invalid move' do
      board = Board.new
      board.place_symbol(0, 0, 'X') # First move
      expect(board.place_symbol(0, 0, 'O')).to be false # Second move at the same spot

      # Verify that the board is not modified
      board_state = board.instance_variable_get(:@board)
      expect(board_state[0][0]).to eq('X') # Still has the original 'X'
    end
  end

  describe '#valid_move?' do
    it 'returns true for a valid move' do
      board = Board.new
      # Set up the board
      expect(board.valid_move?(1, 1)).to be true
    end

    it 'returns false for an invalid move' do
      board = Board.new
      expect(board.valid_move?(3, 0)).to be false
    end
  end

  describe '#winner?' do
    it 'returns true' do
      board = Board.new
      3.times { |i| board.place_symbol(i, i, 'X') } # Fills the diagonal from top-left to bottom-right with 'X'
      expect(board.winner?).to be true
    end
  end
end

RSpec.describe Game do
  describe '#play' do
    it 'plays the game' do
      game = Game.new
      # Set up the game
      # ...
      expect { game.play }.to output.to_stdout
    end
  end
end
