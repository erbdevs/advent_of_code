class PossibleGamesFinder
  Game = Struct.new(:id, :max_red_cubes, :max_green_cubes, :max_blue_cubes)

  def initialize(file_content:)
    @file_content = file_content
  end

  def possible_games(red:, green:, blue:)
    games.sum do |game|
      if valid_game?(game, red, green, blue)
        game.id
      else
        0
      end
    end
  end

  def power
    games.sum do |game|
      game.max_red_cubes * game.max_green_cubes * game.max_blue_cubes
    end
  end

private

  attr_reader :file_content

  def games
    @games ||= file_content.each_line.map do |line|
      split_1, rounds = line.split(":")

      game_id = split_1.match(/Game (\d+)/)[1].to_i
      game = Game.new(id: game_id, max_red_cubes: 0, max_green_cubes: 0, max_blue_cubes: 0)

      rounds.split(";").each do |round|
        r_red = round.scan(/(\d+) red/).flatten.first.to_i
        r_green = round.scan(/(\d+) green/).flatten.first.to_i
        r_blue = round.scan(/(\d+) blue/).flatten.first.to_i

        game.max_red_cubes = r_red if r_red > game.max_red_cubes
        game.max_green_cubes = r_green if r_green > game.max_green_cubes
        game.max_blue_cubes = r_blue if r_blue > game.max_blue_cubes
      end

      game
    end
  end

  def valid_game?(game, red, green, blue)
    return false if game.max_red_cubes > red
    return false if game.max_green_cubes > green
    return false if game.max_blue_cubes > blue

    true
  end
end
