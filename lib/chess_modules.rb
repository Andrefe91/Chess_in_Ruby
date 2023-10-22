module Chess_methods
  def calculate_movements(position, movements_coordinates)
    valid_movements = []

    movements_coordinates.map do |movement|
      x = movement[0] + position[0]
      y = movement[1] + position[1]

      valid_movements.append([x, y]) if (((0..7).cover?(x)) && ((0..7).cover?(y)))
    end

    return valid_movements
  end

  def create_white_pieces
    color = "white"
    pieces_array << Rook.new([7,0], color)
    pieces_array << Knight.new([7,1], color)
    pieces_array << Bishop.new([7,2], color)
    pieces_array << King.new([7,3], color)
    pieces_array << Queen.new([7,4], color)
    pieces_array << Bishop.new([7,5], color)
    pieces_array << Knight.new([7,6], color)
    pieces_array << Rook.new([7,7], color)

    8.times do |column|
      pieces_array << Pawn.new([6, column], color)
    end
  end

  def create_black_pieces
    color = "black"
    pieces_array << Rook.new([0,0], color)
    pieces_array << Knight.new([0,1], color)
    pieces_array << Bishop.new([0,2], color)
    pieces_array << King.new([0,3], color)
    pieces_array << Queen.new([0,4], color)
    pieces_array << Bishop.new([0,5], color)
    pieces_array << Knight.new([0,6], color)
    pieces_array << Rook.new([0,7], color)

    8.times do |column|
      pieces_array << Pawn.new([1, column], color)
    end
  end

  def return_empty_board
    #Create the board for visualization
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

  def create_position_matrix
    #Create the array to support the different pieces
    [[nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    [nil,nil,nil,nil,nil,nil,nil,nil],
    ]
  end
end
