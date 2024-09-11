require_relative "calculator.rb"

RSpec.describe Calculator do
  describe "#run" do
    subject(:result) { described_class.new(file_content).run}
    
    context "basic" do
      let(:file_content) { "467.#.114."}

      it do
        expect(result).to eq(0)
      end
    end

    context "basic" do
      let(:file_content) { "467*.#.114."}

      it do
        expect(result).to eq(467)
      end
    end

    context "basic" do
      let(:file_content) do
        <<~LINE
          467..114..
          ...*......
          ..35..633.
          ......#...
          617*......
          .....+.58.
          ..592.....
          ......755.
          ...$.*....
          .664.598..
        LINE
      end

      it do
        expect(result).to eq(4361)
      end
    end

    context "basic" do
      let(:file_content) do
        <<~LINE
          1.1
          .*.
          1.1
        LINE
      end

      it do
        expect(result).to eq(4)
      end
    end

    context "basic" do
      let(:file_content) do
        <<~LINE
          111
          1*1
          111
        LINE
      end

      it do
        expect(result).to eq(224)
      end
    end

    context "basic" do
      let(:file_content) do
        <<~LINE
          111.1*
          1*1.1*
          111.1*
        LINE
      end

      it do
        expect(result).to eq(231)
      end
    end
  end
end
