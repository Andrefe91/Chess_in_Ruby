require_relative './board'
require_relative './chess_modules'

require 'rainbow'

class Chess_game
  include Chess_methods

  attr_accessor
  attr_reader :turn, :board, :selected_piece_coordinates

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
