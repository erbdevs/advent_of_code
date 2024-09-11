class FileParser
  Symbol = Struct.new(:value, :y, :x)
  Number = Struct.new(:value, :y, :x_start, :x_end)

  def initialize(file_content)
    @file_content = file_content
  end

  def parse
    symbols = []
    numbers = []

    lines = file_content.split("\n")
    lines.each_with_index do |line, row_number|
      find_symbols(line, 0, []).each do |value, x|
        symbols << Symbol.new(value, row_number, x)
      end
      find_numbers(line, 0, []).each do |value, x_start, x_end|
        numbers << Number.new(value, row_number, x_start, x_end)
      end
    end
    
    [ symbols, numbers ]
  end

private

  attr_reader :file_content

  def find_symbols(line, offset, symbols)
    symbol, index_of_symbol = find_symbol(line[offset..])
    return symbols if symbol.nil?

    index_of_symbol = index_of_symbol + offset
    symbols << [symbol, index_of_symbol]
    find_symbols(line, index_of_symbol + 1, symbols)
  end

  def find_symbol(partial_line)
    symbol = partial_line.scan(/[^\.^\d]/).first
    return unless symbol

    index = partial_line.index(symbol)
    [symbol, index]
  end
  
  def find_numbers(line, offset, numbers)
    number, number_start, number_end = find_number(line[offset..])
    return numbers if number.nil?

    number_start = number_start + offset
    number_end = number_end + offset
    numbers << [number.to_i, number_start, number_end]
    find_numbers(line, number_end + 1, numbers)
  end

  def find_number(partial_line)
    number = partial_line.scan(/\d+/).first
    return unless number

    index = partial_line.index(number)
    [number, index, index + number.size - 1]
  end
end
