require_relative "display"

class Game
  include Display

  def initialize(board = Array.new(6) { Array.new(7, "_") }, input = [])
    @player_one = "red"
    @player_two = "yellow"
    @winner = nil

    @input = input

    @board = board
  end

  def start_game
    Display.intro
    game_loop
  end

  def game_loop
    curr_player = "yellow"
    until @winner
      curr_player = curr_player == "yellow" ? "red" : "yellow" # swap player every turn
      @input = player_input
      place_on_board(input[0].to_i, input[1].to_i)

      @winner = game_over?(player)
    end
  end

  def player_input(player)
    input = []
    until valid_input?(input[0], input[1])
      display_player_input(player)
      input = gets.chomp.split
    end
    input
  end

  def valid_input?(x, y)
    return false unless (x.match?(/[0-6]/) && y.match?(/[0-6]/)) && !x.nil? && !y.nil?

    return false unless @board[x.to_i][y.to_i] == "_"

    true
  end

  def place_on_board(x, y)
  end

  def game_over?(player)
    # check horizontally and vertically
    @board.each_with_index do |row, row_index|
      7.times do |i|
        # left-up (y = x) diagonal
        if @board[row_index][i] == player && @board[row_index - 1][i + 1] == player && @board[row_index - 2][i + 2] == player && @board[row_index - 3][i + 3] == player
          return player
        end

        # horizontal
        return player if row[i] == player && row[i + 1] == player && row[i + 2] == player && row[i + 3] == player

        # prevent from trying to reach row_index that doesnt exist
        next if @board[row_index + 3].nil?

        # left-down (y = -x) diagonal

        if @board[row_index][i] == player && @board[row_index + 1][i + 1] == player && @board[row_index + 2][i + 2] == player && @board[row_index + 3][i + 3] == player
          return player
        end

        # vertical
        if @board[row_index][i] == player && @board[row_index + 1][i] == player && @board[row_index + 2][i] == player && @board[row_index + 3][i] == player
          return player
        end
      end
    end

    false
  end
end
