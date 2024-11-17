require_relative "display"
require_relative "player"

class Game
  include Display

  def initialize(board = Array.new(7) { Array.new(6, "_") })
    player_one = Player.new("red")
    player_two = Player.new("blue")
  end

  def start_game
    Display.intro
    game_loop
  end

  def player_input(player_one)
  end

  def game_loop
  end

  def verify_input
  end
end
