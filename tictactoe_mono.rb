# Player Class
class Player
  attr_reader :name, :symbol

  def initialize(name, symbol)
    @name = name
    @symbol = symbol
  end
end

# Board Class
class Board
  def initialize
    @board = Array.new(3) { Array.new(3, ' ') }
  end

  def full?
    @board.all? { |row| row.none?(' ') }
  end

  def display_board
    @board.each do |row|
      puts row.join(' | ')
      puts '---------'
    end
  end

  def place_symbol(row, col, symbol)
    if valid_move?(row, col)
      @board[row][col] = symbol
      true
    else
      false
    end
  end

  def valid_move?(row, col)
    row.between?(0, 2) && col.between?(0, 2) && @board[row][col] == ' '
  end

  def winner?
    # Check rows, columns, and diagonals for a win
    (0..2).any? do |i|
      row_win = @board[i].uniq.size == 1 && @board[i].first != ' '
      col_win = @board.map { |row| row[i] }.uniq.size == 1 && @board[0][i] != ' '
      row_win || col_win
    end || diagonal_win?
  end

  private

  def create_players
    [Player.new('Player 1', 'X'), Player.new('Player 2', 'O')]
  end

  def game_over?
    @move_count >= 5 && (@board.winner? || @board.full?)
  end

  def diagonal_win?
    diag1 = [@board[0][0], @board[1][1], @board[2][2]]
    diag2 = [@board[0][2], @board[1][1], @board[2][0]]
    (diag1.uniq.size == 1 && diag1.first != ' ') || (diag2.uniq.size == 1 && diag2.first != ' ')
  end
end

# Game Class
class Game
  def initialize
    @board = Board.new
    @players = create_players
    @current_player_index = 0
    @move_count = 0
  end

  def play
    begin
      until game_over?
        current_player = @players[@current_player_index]
        make_move(current_player)
        @move_count += 1
        @board.display_board
        @current_player_index = (@current_player_index + 1) % 2
      end
      conclude_game
    rescue StandardError => e
      puts "An unexpected error occurred: #{e.message}"
    end
  end

  private

  def create_players
    [Player.new('Player 1', 'X'), Player.new('Player 2', 'O')]
  end

  def make_move(player)
    loop do
      puts "#{player.name} (#{player.symbol}), enter row and column (1-3):"
      input = gets.chomp.split
      if input.length != 2 || !input.all? { |i| i.match?(/^\d+$/) }
        puts "Please enter two numbers separated by space."
        next
      end

      row, col = input.map(&:to_i).map { |i| i - 1 } # Adjusting for 0-based indexing
      if row.between?(0, 2) && col.between?(0, 2) && @board.place_symbol(row, col, player.symbol)
        break
      else
        puts "Invalid move. Try again."
      end
    end
  end

  def conclude_game
    if @board.winner?
      winner = @players[(@current_player_index - 1) % 2]
      puts "#{winner.name} wins!"
    else
      puts "It's a draw!"
    end
  end
end

# Uncommment this before running test suit!
# Game.new.play
