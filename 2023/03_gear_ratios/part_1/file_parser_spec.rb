require_relative "file_parser.rb"

RSpec.describe FileParser do
  describe "#parsed_lines" do
    subject(:parsed_lines) { described_class.new(file_content).parse }
    
    context "basic" do
      let(:file_content) { "467.#.114."}

      it do
        symbols = parsed_lines[0]
        symbols_summary = symbols.map { [_1.value, _1.y, _1.x] }
        expect(symbols_summary).to eq(
          [["#", 0, 4]]
        )

        numbers = parsed_lines[1]
        numbers_summary = numbers.map { [_1.value, _1.y, _1.x_start, _1.x_end] }
        expect(numbers_summary).to eq(
          [
            # value | y | x_start | x_end
            [    467,  0,        0,     2 ],
            [    114,  0,        6,     8 ],
          ]
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
        symbols = parsed_lines[0]
        symbols_summary = symbols.map { [_1.value, _1.y, _1.x] }
        expect(symbols_summary).to eq(
          [
            ["*", 1, 3],
            ["#", 3, 6],
            ["*", 4, 3],
            ["+", 5, 5],
            ["$", 8, 3],
            ["*", 8, 5],
          ]
        )

        numbers = parsed_lines[1]
        numbers_summary = numbers.map { [_1.value, _1.y, _1.x_start, _1.x_end] }
        expect(numbers_summary).to eq(
          [
            # value | y | x_start | x_end
            [    467,  0,        0,     2 ],
            [    114,  0,        5,     7 ],
            [     35,  2,        2,     3 ],
            [    633,  2,        6,     8 ],
            [    617,  4,        0,     2 ],
            [     58,  5,        7,     8 ],
            [    592,  6,        2,     4 ],
            [    755,  7,        6,     8 ],
            [    664,  9,        1,     3 ],
            [    598,  9,        5,     7 ],
          ]
        )
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
        symbols = parsed_lines[0]
        symbols_summary = symbols.map { [_1.value, _1.y, _1.x] }
        expect(symbols_summary).to eq(
          [
            ["*", 0, 5],
            ["*", 1, 1],
            ["*", 1, 5],
            ["*", 2, 5],
          ]
        )

        numbers = parsed_lines[1]
        numbers_summary = numbers.map { [_1.value, _1.y, _1.x_start, _1.x_end] }
        expect(numbers_summary).to eq(
          [
            # value | y | x_start | x_end
            [    111,  0,        0,     2 ],
            [      1,  0,        4,     4 ],
            [      1,  1,        0,     0 ],
            [      1,  1,        2,     2 ],
            [      1,  1,        4,     4 ],
            [    111,  2,        0,     2 ],
            [      1,  2,        4,     4 ],
          ]
        )
      end
    end
  end
end
