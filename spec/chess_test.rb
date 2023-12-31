require_relative '../lib/pieces_classes'
require_relative '../lib/board'
require_relative '../lib/chess_game'

describe King do

  describe "#initialize" do

    subject(:king_white) {described_class.new([0,0], "white")}
    subject(:king_black) {described_class.new([0,0], "black")}

    context "When the piece is created" do

     it "as a white piece, the symbol must correspond" do
      expect(king_white.symbol).to eq "♔" #White king piece symbol
     end

     it "as a black piece, the symbol must correspond" do
      expect(king_black.symbol).to eq "♚" #Black king piece symbol
     end
    end
  end
end

describe Chess_board do

  describe "#piece?" do
    subject(:game) { described_class.new }

    context "When moving a piece, the method" do

      it "returns True when the coordinates DO holds a piece" do
        is_a_piece = game.piece?([7,0])

        expect(is_a_piece).to be true
      end

      it "returns False when the coordinates DON'T hold a piece" do
        is_a_piece = game.piece?([5,0])

        expect(is_a_piece).to be false
      end
    end
  end

  describe "#valid_color_piece?" do
    context "when checking a piece color" do
      subject(:game_color) { described_class.new }

      it "returns True when the selected piece is White in white's turn" do
        valid = game_color.valid_color_piece?([7,0], "white")

        expect(valid).to be true
      end

      it "returns False when the selected piece is White in black's turn" do
        valid = game_color.valid_color_piece?([7,0], "black")

        expect(valid).to_not be true
      end

      it "returns True when the selected piece is Black in Black's turn" do
        valid = game_color.valid_color_piece?([0,0], "black")

        expect(valid).to be true
      end

      it "returns False when the selected piece is Black in White's turn" do
        valid = game_color.valid_color_piece?([0,0], "white")

        expect(valid).to_not be true
      end
    end
  end

  describe "#move_piece" do
    subject(:game) { described_class.new }

    context "When moving a piece, " do

      it "updates the position of it" do
        game.move_piece([7,0],[3,0])

        movement = game.piece?([3,0])

        expect(movement).to be true
      end

      it "returns false when the coordinates DO NOT hold a piece" do
        piece = game.move_piece([5,0],[3,0])

        expect(piece).to be false
      end

      it "kills the piece in the destination tile" do
        piece = game.move_piece([7,4],[7,3])
        piece = game.move_piece([7,3],[5,3])

        exist = game.piece?([7,3])

        expect(exist).to be false
      end
    end
  end

  describe "#kill" do
    context "when trying to kill a piece" do
      subject(:game_kill) { described_class.new}

      it "returns nil when the coordinates DO NOT hold a piece" do
        exist = game_kill.kill([5,0])
        expect(exist).to be nil
      end

      it "changes the state of a piece to 0 -> Dead" do
        game_kill.kill([7,0])

        alive = game_kill.position_matrix[7][0].state

        expect(alive).to eq 0
      end

    end
  end

  describe "#check_mate?" do
    context "when checking for check mate " do
      subject(:game_check_mate) { described_class.new }

      it "returns true when the white king is dead" do
        game_check_mate.white_king.state = 0

        mate = game_check_mate.check_mate?

        expect(mate).to be true
      end

      it "returns true when the black king is dead" do
        game_check_mate.black_king.state = 0

        mate = game_check_mate.check_mate?

        expect(mate).to be true
      end

      it "returns false otherwise" do
        mate = game_check_mate.check_mate?

        expect(mate).to_not be true
      end
    end
  end

  describe "#check?" do
    context "when checking for check" do
      subject(:game_check) { described_class.new }

      it "returns true when the coordinates correspond to the White king position" do
        check = game_check.check?([[7,2],[7,3],[7,4]])

        expect(check).to be true
      end

      it "returns false when the coordinates dont correspond to the White king position" do
        check = game_check.check?([[7,2],[7,4]])

        expect(check).to_not be true
      end

      it "returns true when the coordinates correspond to the Black king position" do
        check = game_check.check?([[0,2],[0,3],[0,4]])

        expect(check).to be true
      end

      it "returns false when the coordinates dont correspond to the Black king position" do
        check = game_check.check?([[0,2],[0,4]])

        expect(check).to_not be true
      end
    end
  end
end

describe Chess_game do
  describe "#valid_coordinates?" do
    context "when checking for valid coordinates" do
      subject(:valid_input) {described_class.new}

      it "returns false when the coordinates dont correspond  to an Array" do
        valid = valid_input.valid_coordinates?(2)
        expect(valid).to be false
      end

      it "returns false when the coordinates are less than 2" do
        valid = valid_input.valid_coordinates?([1])
        expect(valid).to be false
      end

      it "returns false when the coordinates are longer than 2" do
        valid = valid_input.valid_coordinates?([1,2,3])
        expect(valid).to be false
      end

      it "returns false when the row is bigger than 7" do
        valid = valid_input.valid_coordinates?([8,2])
        expect(valid).to be false
      end

      it "returns false when the column is bigger than 7" do
        valid = valid_input.valid_coordinates?([1,8])
        expect(valid).to be false
      end

      it "returns false when the row is not an integer" do
        valid = valid_input.valid_coordinates?([2.5,8])
        expect(valid).to be false
      end

      it "returns false when the column is not an integer" do
        valid = valid_input.valid_coordinates?([2,5.5])
        expect(valid).to be false
      end

      it "returns true when the coordinates are valid" do
        valid = valid_input.valid_coordinates?([2,5])
        expect(valid).to be true
      end
    end
  end

  describe "#to_array" do
    context "Converting input to an array" do
      subject(:game_array) {described_class.new}

      it "returns an array" do
        array = game_array.to_array("[1,2]")
        expect(array).to eq [1,2]
      end
    end
  end

  describe "#return_piece" do
    context "When selecting a valid coordinate" do
      let(:game_piece) { described_class.new }

      it "Returns a Pawn if selected coordinate is [6,1]" do
        game_piece.instance_variable_set(:@selected_piece_coordinates, [6,1])
        piece = game_piece.return_piece
        clase = piece.type

        expect(clase).to eq "Pawn"
      end
    end
  end

end
