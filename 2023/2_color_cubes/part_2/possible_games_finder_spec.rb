require_relative "possible_games_finder.rb"

RSpec.describe PossibleGamesFinder do
  describe ".identify" do
    subject do
      described_class.possible_games(red: possible_reds, green: possible_greens, blue: possible_blues, file_content:)
    end

    context "1" do
      let(:possible_reds) { 1 }
      let(:possible_greens) { 0 }
      let(:possible_blues) { 0 }
      let(:file_content) { "Game 1: 2 red" }

      it do
        expect(subject).not_to eq(1)
      end
    end

    context "2" do
      let(:possible_reds) { 1 }
      let(:possible_greens) { 0 }
      let(:possible_blues) { 0 }
      let(:file_content) { "Game 1: 1 red" }

      it do
        expect(subject).to eq(1)
      end
    end

    context "3" do
      let(:possible_reds) { 1 }
      let(:possible_greens) { 0 }
      let(:possible_blues) { 0 }
      let(:file_content) { "Game 1: 1 red, 2 blue" }

      it do
        expect(subject).not_to eq(1)
      end
    end

    context "4" do
      let(:possible_reds) { 1 }
      let(:possible_greens) { 0 }
      let(:possible_blues) { 0 }
      let(:file_content) { "Game 1: 1 red, 0 blue" }

      it do
        expect(subject).to eq(1)
      end
    end
  end
end
