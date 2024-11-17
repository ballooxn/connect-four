require_relative "../lib/game"

describe Game do
  describe "game_over?" do
    context "when horizontal win" do
      "returns "
    end
  end

  describe "place_on_board" do
  end

  describe "valid_input?" do
    subject(:verify_input) { described_class.new }

    context "when given valid input" do
      it "returns true" do
        expect(verify_input.valid_input?("3", "4")).to be_truthy
      end
    end

    context "when given input out of range" do
      it "returns false" do
        expect(verify_input.valid_input?("9", "7")).to be_falsey
      end
    end

    context "when given letters" do
      it "returns false" do
        expect(verify_input.valid_input?("a", "o")).to be_falsey
      end
    end
  end

  describe "player_input" do
    subject(:get_input) { described_class.new }

    before do
      allow(get_input).to receive(:gets).and_return("n")
      allow(get_input).to receive(:display_player_input)
    end

    context "when valid_input is true" do
      before do
        allow(get_input).to receive(:valid_input?).and_return(true)
      end
      it "checks for valid_input once" do
        expect(get_input).to receive(:valid_input?).once
        get_input.player_input("red")
      end
    end

    context "when valid_input is false twice then true" do
      before do
        allow(get_input).to receive(:valid_input?).and_return(false, false, true)
      end
      it "checks for valid_input thrice" do
        expect(get_input).to receive(:valid_input?).exactly(3).times
        get_input.player_input(player_one)
      end
    end
  end
end
