require_relative './pieces_classes'
require_relative './chess_modules'

class Chess_board
  include Chess_methods

  attr_accessor :pieces_array, :board, :position_matrix

  def initialize
    @pieces_array = []
    @position_matrix = []
    @board = return_empty_board

    #Included in the chess_module file, this two methods populate the board with
    #the pieces
    create_white_pieces
    create_black_pieces
  end

  private


  def return_empty_board
    [["▢","◼","▢","◼","▢","◼","▢","◼"],
    ["◼","▢","◼","▢","◼","▢","◼","▢"],
    ["▢","◼","▢","◼","▢","◼","▢","◼"],
    ["◼","▢","◼","▢","◼","▢","◼","▢"],
    ["▢","◼","▢","◼","▢","◼","▢","◼"],
    ["◼","▢","◼","▢","◼","▢","◼","▢"],
    ["▢","◼","▢","◼","▢","◼","▢","◼"],
    ["◼","▢","◼","▢","◼","▢","◼","▢"],
    ]
  end




end

board = Chess_board.new
puts board.board
