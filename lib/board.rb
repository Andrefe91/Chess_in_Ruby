require_relative './pieces_classes'
require_relative './chess_modules'

require 'rainbow'

class Chess_board
  include Chess_methods

  attr_accessor :pieces_array, :clear_board, :position_matrix

  def initialize
    @pieces_array = []
    @position_matrix = create_position_matrix
    @clear_board = return_empty_board

    #Included in the chess_module file, this two methods populate the board with
    #the pieces
    create_white_pieces
    create_black_pieces
    update_position_matrix
  end

  def pretty_print(selected = nil)
    #For the pretty printing, we must mix the two matrix, the clear_board and
    #position matrix.

    puts Rainbow("  0 1 2 3 4 5 6 7").yellow
    clear_board.each_with_index do |row, row_index|
      print Rainbow("#{row_index} ").yellow
      row.each_with_index do |tile, column_index|
        piece = position_matrix[row_index][column_index]

        #Distinguish the piece from the empty tile
        piece == nil ? (print tile) : (print piece.symbol)
        print " "
      end
      puts "\n"
    end

  end

  private

  def update_position_matrix
    #Now, populate the matrix with the chess piece objects
    @pieces_array.each do |piece|

      row = piece.position[0]
      column = piece.position[1]

      @position_matrix[row][column] = piece

    end
  end
end

board = Chess_board.new
board.pretty_print
