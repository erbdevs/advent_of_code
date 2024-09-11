require_relative "file_parser.rb"

class Calculator
  def initialize(file_content)
    @symbols, @numbers = FileParser.new(file_content).parse
  end

  def run
    valid_numbers = []

    symbols.each do |sym|
      valid_numbers << 
        numbers.select do |number|
          valid_xs = (number.x_start - 1)..(number.x_end + 1)
          (
            (number.y == sym.y + 1 || number.y == sym.y - 1) && valid_xs.include?(sym.x)
          ) || (
            number.y == sym.y && (number.x_start == sym.x + 1 || number.x_end == sym.x - 1)
          )
        end
    end

    valid_numbers.flatten.sum(&:value)
  end

private

  attr_reader :symbols, :numbers
end
