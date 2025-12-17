class Unlocker
  attr_reader :wheel, :number_of_elements

  def initialize(number_of_elements:, initial_position:)
    @number_of_elements = number_of_elements
    @wheel = prepare_wheel(initial_position)
    @password = 0
  end

  def rotate(command)
    command.sub!("L", "-")
    command.sub!("R", "+")
    clicks = command.to_i

    zero_hits = 0
    if clicks.positive? || clicks.zero?
      clicks.abs.times do
        zero_hits +=1 if rotate_1_right == 0
      end
    else
      clicks.abs.times do
        zero_hits +=1 if rotate_1_left == 0
      end
    end

    zero_hits
  end

private

  def prepare_wheel(initial_position)
    w = (0..(number_of_elements-1)).to_a
    w[initial_position..] + w[..(initial_position-1)]
  end

  def rotate_1_left
    # @wheel = @wheel[clicks..] + @wheel[..(clicks-1)]
    @wheel = @wheel[-1..] + @wheel[..-2]
    @wheel[0]
  end

  def rotate_1_right
    # @wheel = @wheel[clicks..] + @wheel[..(clicks-1)]
    @wheel = @wheel[1..] + @wheel[..0]
    @wheel[0]
  end

end
