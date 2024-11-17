require_relative "display"
require_relative "player"

class Game
  include Display

  def initialize(board = Array.new(6) { Array.new(7, "_") })
    @player_one = "red"
    @player_two = "blue"
    @winner = nil

    @board = board
  end

  def start_game
    Display.intro
    game_loop
  end

  def game_loop
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

    true
  end

  def place_on_board(x, y)
  end

  def game_over?(player)
  end
end
