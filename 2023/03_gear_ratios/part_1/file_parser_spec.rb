require_relative "file_parser.rb"

RSpec.describe FileParser do
  describe "#parsed_lines" do
    subject(:parsed_lines) { described_class.new(file_content).parse }
    
    context "basic" do
      let(:file_content) { "467.#.114.."}

      it do
        expect(parsed_lines).to eq(
          {
            0 => { 0 => 467, 4 => "#", 6 => 114} 
          }
        )
      end
    end

    context "harder" do
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
        expect(parsed_lines).to eq(
          {
            0 => { 0 => 467, 5 => 114 },
            1 => { 3 => "*" },
            2 => { 2 => 35, 6 => 633 },
            3 => { 6 => "#" },
            4 => { 0 => 617, 3 => "*" },
            5 => { 5 => "+", 7 => 58 },
            6 => { 2 => 592 },
            7 => { 6 => 755 },
            8 => { 3 => "$", 5 => "*" },
            9 => { 1 => 664, 5 => 598 },
          }
        )
      end
    end
  end
end
