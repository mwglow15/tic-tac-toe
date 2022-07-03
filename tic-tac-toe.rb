class Game
  def initialize(player_1_class, player_2_class)
    @board = Array.new(10)

    @current_player = 0
    @players = [player_1_class.new(self, 'X'), player_2_class.new(self, 'X')]
  end

  def play
    current_player.ask_name
    opposing_player.ask_name

    loop do
      current_player.play_turn

      return "#{current_player.name} wins!" if game_won?
      return 'Draw!' if board_full?

      switch_players!
    end
  end

  def current_player
    @players[@current_player]
  end

  def opposing_player
    @players[(@current_player + 1) % 2]
  end

  def switch_players!
    @current_player = (@current_player + 1) % 2
  end

  attr_accessor :board
end

class Player
  def initialize(game, symbol)
    @game = game
    @symbol = symbol
  end

  attr_reader :symbol
end

class Human < Player
  def play_turn
    puts "Choose a tile to play!"
    loop do
      @tile = gets.to_i

      if valid_move?
        @game.board[@tile] = @marker
      else
        puts "Please choose a valid tile!"
      end
    end
  end

  def ask_name
    puts "What is your name?"
    @name = gets.chomp
  end

  def valid_move?
    p @game.board[@tile]
    return unless @game.board[@tile]
  end
end

Game.new(Human, Human).play
