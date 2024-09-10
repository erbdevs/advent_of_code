class FileParser
  def initialize(file_content)
    @file_content = file_content
  end

  def parse
    parsed_lines = {}

    lines = file_content.split("\n")
    lines.each_with_index do |line, index|
      non_dots = line.scan(/\d+|[\*\+$#]/)
      parsed_lines[index] = {}

      non_dots.each do |thing|
        index_of_thing = line.index(thing)
        begin
          parsed_lines[index][index_of_thing] = Integer(thing)
        rescue ArgumentError
          parsed_lines[index][index_of_thing] = thing
        end
      end
    end
    
    parsed_lines
  end

private

  attr_reader :file_content
end
