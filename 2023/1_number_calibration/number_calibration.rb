file_name = ARGV[0]
def numbers_range
  49..57
end

def written_numbers
  [
    ["one", "1"],
    ["two", "2"],
    ["three", "3"],
    ["four", "4"],
    ["five", "5"],
    ["six", "6"],
    ["seven", "7"],
    ["eight", "8"],
    ["nine", "9"],
  ]
end

def first_number(found, line)
  return found if found

  written_numbers.each do |written, number|
    if line.start_with?(written)
      found = number
      break
    end
  end
  if found.nil?
    char = line[0]
    found = char if numbers_range.include?(char.ord)
  end

  first_number(found, line[1..])
end

def last_number(found, line)
  return found if found

  written_numbers.each do |written, number|
    if line.start_with?(written.reverse)
      found = number
      break
    end
  end
  if found.nil?
    char = line[0]
    found = char if numbers_range.include?(char.ord)
  end

  last_number(found, line[1..])
end

numbers = []
File.read(file_name).each_line do |line|
  first = first_number(nil, line)
  last = last_number(nil, line.reverse)
  numbers << "#{first}#{last}".to_i
end

puts numbers.sum
