require_relative "../lib/game"

describe Game do
  describe "game_over?" do # rubocop:disable Metrics/BlockLength
    context "when red horizontal win" do
      board = [Array.new(7, "_"), Array.new(7, "_"), Array.new(7, "_"), %w[_ _ _ red red red red], Array.new(7, "_"),
               Array.new(7, "_")]
      subject(:red_horiz) { described_class.new(board) }

      it "returns red" do
        expect(red_horiz.game_over?("red")).to eq("red")
      end
    end

    context "when red vertical win" do
      board = [Array.new(7, "_"), Array.new(7, "_"), %w[_ _ _ _ _ red _], %w[_ _ _ _ _ red _], %w[_ _ _ _ _ red _],
               %w[_ _ _ _ _ red _]]
      subject(:red_vert) { described_class.new(board) }

      it "returns red" do
        expect(red_vert.game_over?("red")).to eq("red")
      end
    end

    context "when left-down diagonal" do
      board = [Array.new(7, "_"), Array.new(7, "_"), %w[_ _ red _ _ _ _], %w[_ _ _ red _ _ _], %w[_ _ _ _ red _ _],
               %w[_ _ _ _ _ red _]]
      subject(:red_diag) { described_class.new(board) }

      it "returns red" do
        expect(red_diag.game_over?("red")).to eq("red")
      end
    end

    context "when left-up diagonal" do
      board = [Array.new(7, "_"), Array.new(7, "_"), %w[_ _ _ _ _ yellow _], %w[_ _ _ _ yellow _ _], %w[_ _ _ yellow _ _ _],
               %w[_ _ yellow _ _ _ _]]
      subject(:yellow_diag) { described_class.new(board) }

      it "returns yellow" do
        expect(yellow_diag.game_over?("yellow")).to eq("yellow")
      end
    end

    context "when no winner" do
      subject(:no_winner) { described_class.new }

      it "returns false" do
        expect(no_winner.game_over?("yellow")).to be_falsey
      end
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
        get_input.player_input("red")
      end
    end
  end
end
