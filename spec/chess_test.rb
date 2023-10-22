require_relative '../lib/pieces_classes'

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
