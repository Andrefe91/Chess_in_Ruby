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
    pieces_array << Rook.new([6,0], color)
    pieces_array << Knight.new([6,1], color)
    pieces_array << Bishop.new([6,2], color)
    pieces_array << King.new([6,3], color)
    pieces_array << Queen.new([6,4], color)
    pieces_array << Bishop.new([6,5], color)
    pieces_array << Knight.new([6,6], color)
    pieces_array << Rook.new([6,7], color)

    8.times do |column|
      pieces_array << Pawn.new([5, column], color)
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
end
