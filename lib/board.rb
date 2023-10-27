require_relative './pieces_classes'
require_relative './chess_modules'

require 'rainbow'

class Chess_board
  include Chess_methods

  attr_accessor :pieces_array, :clear_board, :position_matrix
  attr_reader :white_king, :black_king

  def initialize
    @pieces_array = []
    @position_matrix = create_position_matrix
    @clear_board = return_empty_board

    #Included in the chess_module file, this two methods populate the board with
    #the pieces
    create_white_pieces
    create_black_pieces

    #And this creates the position matrix
    update_position_matrix

    #This is usefull for the win condition
    @white_king = pieces_array[3]
    @black_king = pieces_array[19]
  end

  def pretty_print(selected = nil,valid_movements_array = [])
    #For the pretty printing, we must mix the two matrix, the clear_board and
    #position matrix.

    puts Rainbow("  0 1 2 3 4 5 6 7").yellow

    clear_board.each_with_index do |row, row_index|
      print Rainbow("#{row_index} ").yellow
      row.each_with_index do |tile, column_index|
        piece = position_matrix[row_index][column_index]

        #Distinguish the piece from the empty tile
        if piece == nil
          #If tile is within the valid movements, print it in color
          if valid_movements_array.include?([row_index,column_index])
            print Rainbow("#{tile}").yellow
          else
            print tile
          end
        else
          #Print red if the piece is selected
          if [row_index,column_index] == selected
            print Rainbow(piece.symbol).red.bright
          else
            #If the piece is a target, print it in color
            if valid_movements_array.include?([row_index,column_index])
              print Rainbow("#{piece.symbol}").yellow
            else
              print piece.symbol
            end
          end
        end
        print " "
      end
      puts "\n"
    end

  end

  def update_position_matrix
    @position_matrix = create_position_matrix #This resets the position matrix

    #Now, populate the matrix with the chess piece objects
    @pieces_array.each do |piece|

      row = piece.position[0]
      column = piece.position[1]

      #Only add the live pieces in every update
      if piece.state == 1
        @position_matrix[row][column] = piece
      end
    end
  end

  def piece?(coordinates)
    tile = @position_matrix[coordinates[0]][coordinates[1]]

    #Check if the selected tile holds a Piece class object
    tile.class.ancestors.include?(Pieces)
  end

  def valid_color_piece?(coordinate, color)
    row = coordinate[0]
    column = coordinate[1]

    begin #Rescue code in case the selected tile doesnt have a chess piece
      position_matrix[row][column].color == color
    rescue NoMethodError
      return false
    end
  end

  def move_piece(coordenada_inicial, coordenada_final)
    return false unless piece?(coordenada_inicial) #If not a piece, abort the method

    kill(coordenada_final) #Kill the piece if found in the objective position

    #Replace the position coordinates and update the position matrix
    @position_matrix[coordenada_inicial[0]][coordenada_inicial[1]].position = coordenada_final
    update_position_matrix
  end

  def kill(coordenada_final)
    return unless piece?(coordenada_final) #If not a piece in the tile, abort the method

    @position_matrix[coordenada_final[0]][coordenada_final[1]].state = 0 #Kills the piece
  end

  def check?(coordinates)
    #we use the destination/possible coordinates to identify if the king is in danger
    white_king_coordinates = white_king.position
    black_king_coordinates = black_king.position

    if (coordinates.include?(white_king_coordinates) || coordinates.include?(black_king_coordinates))
      return true
    end
    return false
  end

  def check_mate?
    if (white_king.state == 0 || black_king.state == 0)
      return true
    end
    return false
  end
end

#board = Chess_board.new
#board.pretty_print(board.position_matrix[7][0])
