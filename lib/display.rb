module Display
  def self.intro
    puts "Welcome to Connect Four!"
  end

  def self.display_player_input(player)
    puts "#{player == 'r' ? 'Red' : 'Yellow'} player, enter your two numbers (0-6) seperated by a space:"
  end

  def self.display_board(board)
    # Change row numbers to column numbers
    puts "\nCurrent Board:"
    board.each_with_index do |row, index|
      puts "#{index}. #{row.join(' | ')}"
    end
    puts "------------"
  end

  def self.display_winner(player)
    if player == "tie"
      puts "Game has ended in a TIE!"
    else
      puts "#{player == 'r' ? 'Red' : 'Yellow'} player has won!"
    end
  end
end
