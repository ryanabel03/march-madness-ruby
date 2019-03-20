require_relative './base.rb'

class TopSeedStrategy < Base
  def self.decide_winner(team_one:, team_two:)
    team_one.seed.lower?(team_two.seed) ? [team_one, team_two] : [team_two, team_one]
  end
end
