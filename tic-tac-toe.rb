class Game
  def initialize(player_1_class, player_2_class)
    @board = Array.new(10)

    @players = [player_1_class.new(self, 'X'), player_2_class.new(self, 'X')]
  end

  def play
    loop do
      current_player.play_turn

      if game_won
        return "#{current_player.name} wins!"

end

class Player
  def initialize(game,symbol)
    @game = game
    @symbol = symbol
  end
end
