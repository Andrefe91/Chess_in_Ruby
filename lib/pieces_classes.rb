

class Pieces
  @@number_of_pieces = 0
  attr_accessor :position, :state
  attr_reader :color, :symbol, :type

  def initialize(position, color = nil)
    @position = position
    @color = color
    @state = 1 #Binary state, 1 for alive and 0 for dead
    @symbol = nil
    @@number_of_pieces += 1

  end

  def self.number
    @@number_of_pieces
  end
end

class King < Pieces

  def initialize(position, color)
    super(position, color)
    #The valid movements are calculated for the position,
    #every update to the position must update the valid
    #movements
    @symbol = (color == "white" ? "\u{2654}": "\u{265A}")
    @type = "King"
  end

end

class Queen < Pieces

  def initialize(position, color)
    super(position, color)
    #The valid movements are calculated for the position,
    #every update to the position must update the valid
    #movements
    @symbol =  (color == "white" ? "\u{2655}": "\u{265B}")
    @type = "Queen"
  end

end

class Rook < Pieces

  def initialize(position, color)
    super(position, color)
    #The valid movements are calculated for the position,
    #every update to the position must update the valid
    #movements
    @symbol =  (color == "white" ? "\u{2656}": "\u{265C}")
    @type = "Rook"
  end

end

class Bishop < Pieces

  def initialize(position, color)
    super(position, color)
    #The valid movements are calculated for the position,
    #every update to the position must update the valid
    #movements
    @symbol =  (color == "white" ? "\u{2657}": "\u{265D}")
    @type = "Bishop"
  end

end

class Knight < Pieces

  def initialize(position, color)
    super(position, color)
    #The valid movements are calculated for the position,
    #every update to the position must update the valid
    #movements
    @symbol =  (color == "white" ? "\u{2658}": "\u{265E}")
    @type = "Knight"
  end

end

class Pawn < Pieces

  def initialize(position, color)
    super(position, color)
    #The valid movements are calculated for the position,
    #every update to the position must update the valid
    #movements
    @symbol =  (color == "white" ? "\u{2659}": "\u{265F}")
    @type = "Pawn"
  end

end
