require_relative "possible_games_finder.rb"

RSpec.describe PossibleGamesFinder do
  describe ".possible_games" do
    subject do
      described_class.new(file_content:)
                     .possible_games(red: possible_reds, green: possible_greens, blue: possible_blues)
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

  describe ".power" do
    subject do
      described_class.new(file_content:).power
    end

    context "2" do
      let(:file_content) { "Game 1: 2 red; 2 blue; 2 green" }

      it do
        expect(subject).to eq(8)
      end
    end
  end
end
