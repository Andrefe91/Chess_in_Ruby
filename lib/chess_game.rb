require_relative './board'


require 'rainbow'

class Chess_game
  attr_accessor :selected_piece
  attr_reader :turn, :board

  def initialize
    @board = Chess_board.new
    @turn = "white"
    @selected_piece_coordinates = nil
  end

  def play
    print_welcome
    board.pretty_print
    call_turn
  end

  def print_welcome
    puts <<~MULTI_LINE_TEXT
      #{Rainbow("WELCOME !!").yellow}

      This is a game of #{Rainbow("chess").yellow}, implement in Ruby and played on the console

      The game can be saved and continued in any moment, just remember to
      type 'save' when selecting a piece

      Now, let's start the game !!

    MULTI_LINE_TEXT
  end

  def call_turn
    puts "------------------"
    puts "It's #{Rainbow(@turn).yellow} turn, select a piece by coordinate: "
  end

  def select_piece(coordinates)
    
  end

  def change_turn
    if @turn == "white"
      @turn = "black"
    else
      @turn = "white"
    end
  end

  def valid_coordinates(coordinates)
    #Make sure the coordinates are valid
    row = coordinates[0]
    column = coordinates[1]

    #The coordinates must be an Array
    return false unless coordinates.class == Array

    #The Array must contain only two elements
    return false unless coordinates.size == 2

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
end

game = Chess_game.new
game.play
