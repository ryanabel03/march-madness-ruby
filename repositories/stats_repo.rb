class StatsRepo
  def self.load_stats
    CSV.parse("../data/RegularSeasonDetailedResults.csv", headers: true).map { |g| GameStats.new(winning_team_id: g[2], losing_team_id: g[4], location: g[6]) }
  end
  def self.stats_for_team(team:)
  end
end

class GameStats
  attr_reader :winning_team_id, :losing_team_id, :location

  def initialize(winning_team_id:, losing_team_id:, location:)
    @winning_team_id = winning_team_id
    @losing_team_id = losing_team_id
    @location = location
  end
end