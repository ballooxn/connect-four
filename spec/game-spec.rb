require_relative "../lib/game"

describe Game do
  describe "game_over?" do # rubocop:disable Metrics/BlockLength
    context "when red horizontal win" do
      board = [Array.new(7, "_"), Array.new(7, "_"), Array.new(7, "_"), %w[_ _ _ r r r r], Array.new(7, "_"),
               Array.new(7, "_")]
      subject(:red_horiz) { described_class.new(board) }

      it "returns red" do
        expect(red_horiz.game_over?("r")).to eq("r")
      end
    end

    context "when red vertical win" do
      board = [Array.new(7, "_"), Array.new(7, "_"), %w[_ _ _ _ _ r _], %w[_ _ _ _ _ r _], %w[_ _ _ _ _ r _],
               %w[_ _ _ _ _ r _]]
      subject(:red_vert) { described_class.new(board) }

      it "returns red" do
        expect(red_vert.game_over?("r")).to eq("r")
      end
    end

    context "when left-down diagonal" do
      board = [Array.new(7, "_"), Array.new(7, "_"), %w[_ _ r _ _ _ _], %w[_ _ _ r _ _ _], %w[_ _ _ _ r _ _],
               %w[_ _ _ _ _ r _]]
      subject(:red_diag) { described_class.new(board) }

      it "returns red" do
        expect(red_diag.game_over?("r")).to eq("r")
      end
    end

    context "when left-up diagonal" do
      board = [Array.new(7, "_"), Array.new(7, "_"), %w[_ _ _ _ _ y _], %w[_ _ _ _ y _ _], %w[_ _ _ y _ _ _],
               %w[_ _ y _ _ _ _]]
      subject(:yellow_diag) { described_class.new(board) }

      it "returns yellow" do
        expect(yellow_diag.game_over?("y")).to eq("y")
      end
    end

    context "when turns = 42" do
      subject(:tie) { described_class.new(Array.new(6) { Array.new(7, "_") }, [], 42) }
      it "returns 'tie'" do
        expect(tie.game_over?("r")).to eq("tie")
      end
    end

    context "when no winner" do
      subject(:no_winner) { described_class.new }

      it "returns false" do
        expect(no_winner.game_over?("y")).to be_falsey
      end
    end
  end

  describe "place_on_board" do
    context "given 'red' and (2, 2)" do
      subject(:board_placing) { described_class.new }

      it "places a 'red' at [2][2]" do
        board_placing.place_on_board("r", 2, 2)
        expect(board_placing.instance_variable_get(:@board)[2][2]).to eq("r")
      end
    end
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
        get_input.player_input("r")
      end
    end

    context "when valid_input is false twice then true" do
      before do
        allow(get_input).to receive(:valid_input?).and_return(false, false, true)
      end
      it "checks for valid_input thrice" do
        expect(get_input).to receive(:valid_input?).exactly(3).times
        get_input.player_input("r")
      end
    end
  end
end
