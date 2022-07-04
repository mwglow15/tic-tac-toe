class Game
  WINNING_MOVES = [[1,2,3],[4,5,6],[7,8,9],[1,4,7],[2,5,8],[3,6,9],[1,5,9],[3,5,7]]

  def initialize(player_1_class, player_2_class)
    @board = Array.new(10)

    @current_player = 0
    @players = [player_1_class.new(self, 'X'), player_2_class.new(self, 'O')]
  end

  def play
    current_player.ask_name
    opposing_player.ask_name

    loop do
      play_turn(current_player)
      print_board

      if game_won?
        puts "#{current_player.name} wins!"
        return
      elsif board_full?
        puts "Draw!"
        return
      end

      switch_players!
    end
  end

  def play_turn(player)
    placement = player.placement
    @board[placement] = player.symbol
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

  def print_board
    column_div = "|"
    row_div = "--+---+--"
    display_board = []

    (1..9).each do |index|
      if @board[index].nil?
        display_board[index-1] = index
      else
        display_board[index-1] = @board[index]
      end
    end

    puts nil
    puts "#{display_board[0]} #{column_div} #{display_board[1]} #{column_div} #{display_board[2]}"
    puts row_div
    puts "#{display_board[3]} #{column_div} #{display_board[4]} #{column_div} #{display_board[5]}"
    puts row_div
    puts "#{display_board[6]} #{column_div} #{display_board[7]} #{column_div} #{display_board[8]}"
    puts nil
  end

  def game_won?
    WINNING_MOVES.any? do |move|
      move.all? { |space| @board[space] == current_player.symbol }
    end
  end

  def board_full?
    if (1..9).select { |position| @board[position].nil? }
      false
    else
      true
    end
  end

  attr_accessor :board
end

class Player
  def initialize(game, symbol)
    @game = game
    @symbol = symbol
  end

  def valid_move?(tile)
    return true unless @game.board[tile]
  end

  attr_reader :symbol
end

class Human < Player
  def placement
    puts "Choose a tile to play!"
    loop do
      tile = gets.chomp.to_i

      return tile if valid_move?(tile)

      puts "Please choose a valid tile!"
    end
  end

  def ask_name
    puts "What is your name?"
    @name = gets.chomp
  end

  attr_reader :name
end

class Computer < Player
  def placement
    loop do
      tile = rand(8) + 1
      return tile if valid_move?(tile)
    end
  end

  def ask_name
    puts "I am the computer"
  end
end

Game.new(Human, Computer).play
