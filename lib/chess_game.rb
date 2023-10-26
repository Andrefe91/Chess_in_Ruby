require_relative './board'
require_relative './chess_modules'

require 'rainbow'

class Chess_game
  include Chess_methods

  attr_accessor :selected_piece
  attr_reader :turn, :board, :selected_piece_coordinates, :valid_movements

  def initialize
    @board = Chess_board.new
    @turn = "black"
    @selected_piece_coordinates = nil
    @selected_piece = nil
    @valid_movements = []
  end

  def play
    print_welcome
    board.pretty_print
    game_loop
    win_text
  end

  def game_loop
    until board.check_mate?
      change_turn
      call_turn
      select_piece
      board.pretty_print(selected_piece_coordinates)
      @selected_piece = return_piece
      valid_movements_rest
      move_piece
      board.pretty_print
    end
  end

  def print_welcome
    puts <<~MULTI_LINE_TEXT
      #{Rainbow("WELCOME !!").yellow}

      This is a game of #{Rainbow("Chess").yellow}, implement in Ruby and played on the console

      The game can be #{Rainbow("'save'").aliceblue.bright} and continued in any moment, just remember to
      type #{Rainbow("save").aliceblue.bright} when selecting a piece by coordinate.

      Now, let's start the game !!

    MULTI_LINE_TEXT
  end


  def call_turn
    puts "------------------"
    print "It's #{Rainbow(@turn).yellow}'s turn, select a piece by coordinate: "
  end

  def select_piece
    while true
      coordinates = gets.chomp
      break if (valid_coordinates?(to_array(coordinates)) && board.valid_color_piece?(to_array(coordinates), turn))
      print_error("Invalid Coordinates")
      print "Select a piece by coordinate: "
    end
    @selected_piece_coordinates = to_array(coordinates)
    puts "\nBoard with the selected piece: \n"
  end

  def move_piece
    start_coordinates = @selected_piece_coordinates
    print "\nInput destination coordinates: "

    while true
      end_coordinates = gets.chomp
      break if (valid_coordinates?(to_array(end_coordinates)))
      print_error("Invalid Coordinates")
      print "Please, input again destination coordinates for the piece: "
    end

    end_coordinates = to_array(end_coordinates)

    board.move_piece(start_coordinates,end_coordinates)
    puts "\nOk, the state of the board is: \n"
  end

  def to_array(input)
    return unless input.match?(/\[[0-7],[0-7]\]/)
    [input[1].to_i, input[3].to_i]
  end

  def change_turn
    if @turn == "white"
      @turn = "black"
    else
      @turn = "white"
    end
  end

  def valid_coordinates?(coordinates)

    #Make sure the coordinates are valid:

    #The coordinates must be an Array
    return false unless coordinates.class == Array

    #The Array must contain only two elements
    return false unless coordinates.size == 2

    row = coordinates[0]
    column = coordinates[1]

    #Both coordinates must be 0 or more but less than 7
    return false unless row.between?(0,7)
    return false unless column.between?(0,7)

    #Both coordinates must be integers
    return false unless row.class == Integer
    return false unless column.class == Integer

    return true
  end

  def return_piece(coordinates = selected_piece_coordinates)
    coordinate_row = coordinates[0]
    coordinate_column = coordinates[1]

    board.position_matrix[coordinate_row][coordinate_column]
  end

  def valid_movements(piece)
    #Help distinguish if the piece is a pawn or something else

    valid_movements_rest(piece)
  end

  def generate_coordinates
    coordinates = []
    #The selected piece has all the information we need
    position = @selected_piece.position

    #And now, we obtain the coordinates for a given piece type
    moves = movements(@selected_piece.type)

    moves.each do |series|
      array = [] #This will help preserve the series information

      series.each do |coordinate|
        array.append([coordinate[0]+position[0], coordinate[1]+position[1]])
      end

      coordinates.append(array) #This way, every array inside coordinates it's a series
    end

    coordinates
  end

  def prune_movements
    raw_movements = generate_coordinates

    pruned_coordinates = []

    #For each series, chech if coordinates are between 0 and 7
    raw_movements.each do |series|
      array = [] #This will help preserve the series information
      series.each do |coordinate|
        array.append(coordinate) if (coordinate.max <= 7 && coordinate.min >= 0 )
      end

      #This way, every array inside coordinates it's a series and non viable trajectories arent added
      pruned_coordinates.append(array) if array.length > 0
    end

    pruned_coordinates
  end

  def valid_movements_rest
    #This method returns the valid coordinates for the given piece, except pawn

    #Initialize the variables
    color = @selected_piece.color
    pruned_movements_array = prune_movements
    valid_movements_array = []

    pruned_movements_array.each do |series|
      series.each do |coordinate|
        piece = return_piece(coordinate)
        piece_color = piece.color unless piece.nil?

        if piece.nil? #If empty tile, add
          valid_movements_array.append(coordinate)
        elsif piece_color != @turn #If full tile, with piece of different color, add
          valid_movements_array.append(coordinate)
          break
        else
          break #If full tile with piece of same color, break
        end
      end
    end

    valid_movements_array
  end

  def valid_movements_pawn
    #This method returns the valid coordinates for the given pawn

    #Initialize the variables
    color = @selected_piece.color
    pruned_movements_array = prune_movements
    valid_movements_array = []

    
  end

  def print_error(error)
    #General method to print error in color red to console
    puts "Error: #{Rainbow(error).red}, try again"
  end

  def win_text
    puts <<~MULTI_LINE_TEXT
      #{Rainbow("CONGRATS #{turn.capitalize}'s !!").yellow}, you won the game !!
      What do you say, another round ?? 😉
    MULTI_LINE_TEXT
  end
end

game = Chess_game.new
game.play
