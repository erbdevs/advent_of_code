require_relative "unlocker.rb"

current_position = 50
number_of_elements = 100
unlocker = Unlocker.new(number_of_elements:, initial_position: current_position)

password = 0
File.read("input1.txt").each_line do |line|
  password += unlocker.rotate(line)
end
password
