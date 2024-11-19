module Display
  def self.intro
    puts "Welcome to Connect Four!"
  end

  def self.display_player_input(player)
    puts "#{player == 'r' ? 'Red' : 'Yellow'} player, enter the column number (0-6):"
  end

  def self.display_board(board)
    # Change row numbers to column numbers
    puts "\nCurrent Board:"
    board.each_with_index do |row, index|
      puts "  #{row.join(' | ')}"
    end
    puts "  0.  1.  2.  3.  4.  5.  6."
  end

  def self.display_winner(player)
    if player == "tie"
      puts "Game has ended in a TIE!"
    else
      puts "#{player == 'r' ? 'Red' : 'Yellow'} player has won!"
    end
  end
end
