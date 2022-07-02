class Game
  def initialize(player_1_class, player_2_class)
    @board = Array.new(10)

    @current_player = 0
    @players = [player_1_class.new(self, 'X'), player_2_class.new(self, 'X')]
  end

  def play
    loop do
      current_player.play_turn

      if game_won?
        return "#{current_player.name} wins!"
      elsif board_full?
        return 'Draw!'
      end

      switch_players!
    end
  end

  def switch_players!
    @current_player = (@current_player + 1) % 2
  end
end

class Player
  def initialize(game,symbol)
    @game = game
    @symbol = symbol
  end

  def play_turn
    puts "Choose a tile to play!"
    loop do
      tile = gets.to_i

      if is_valid_move?
        puts "Please choose a valid tile!"
    end

  end
end
