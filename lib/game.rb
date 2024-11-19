require_relative "display"

class Game
  include Display

  def initialize(board = Array.new(6) { Array.new(7, "_") }, input = nil, turns = 0)
    @player_one = "r"
    @player_two = "y"
    @winner = nil
    @turns = turns

    @input = input

    @board = board
  end

  def start_game
    Display.intro
    game_loop
  end

  def game_loop
    curr_player = "y"
    until @winner
      @turns += 1
      curr_player = curr_player == "y" ? "r" : "y" # swap player every turn
      @input = player_input(curr_player)
      place_on_board(curr_player, @input)
      Display.display_board(@board)

      @winner = game_over?(curr_player)
    end
    Display.display_winner
  end

  def player_input(player)
    column = nil
    until valid_input?(column)
      Display.display_player_input(player)
      column = gets.chomp.to_i
    end
    column
  end

  def valid_input?(column)
    return false if column.nil?
    return false unless column.to_s.match?(/[0-6]/)

    return false unless @board[0][column] == "_"

    true
  end

  def place_on_board(player, column)
    @board.each_with_index do |row, i|
      if row[column] == "_" && i == 5
        row[column] = player
        break
      elsif row[column] == "_" && i != 5
        next
      end

      @board[i - 1][column] = player
      break
    end
    p @board
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

    return "tie" if @turns >= 42

    false
  end
end
