class PossibleGamesFinder
  def self.identify(red:, green:, blue:, file_content:)
    new(red:, green:, blue:, file_content:).identify
  end

  def initialize(red:, green:, blue:, file_content:)
    @red = red 
    @green = green
    @blue = blue
    @file_content = file_content
  end

  def identify
    file_parser.sum
  end


private

  attr_reader :red, :green, :blue, :file_content

  def file_parser
    possible_games = []

    file_content.each_line do |line|
      split_1, split_2 = line.split(":")
      game_id = split_1.match(/Game (\d+)/)[1].to_i

      max_red_cubes = 0
      max_green_cubes = 0
      max_blue_cubes = 0
      rounds = split_2.split(";")
      rounds.each do |round|
        r_red = round.scan(/(\d+) red/).flatten.first.to_i
        r_green = round.scan(/(\d+) green/).flatten.first.to_i
        r_blue = round.scan(/(\d+) blue/).flatten.first.to_i

        max_red_cubes = r_red if r_red > max_red_cubes
        max_green_cubes = r_green if r_green > max_green_cubes
        max_blue_cubes = r_blue if r_blue > max_blue_cubes
      end

      possible_games << game_id if valid_max_cubes?(max_red_cubes, max_green_cubes, max_blue_cubes)
    end

    possible_games
  end

  def valid_max_cubes?(r, g, b)
    return false if r > red
    return false if g > green
    return false if b > blue

    true
  end

end
