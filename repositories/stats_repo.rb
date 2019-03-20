class StatsRepo
  def self.get_stats
    CSV.read("./data/RegularSeasonDetailedResults.csv", headers: true).map do |g| 
      GameStats.new(winning_team_id: g[2],
                    losing_team_id: g[4],
                    location: g[6],
                    winning_stats: {
                      score: g[3],
                      field_goals_made: g[8],
                      field_goals_attempted: g[9],
                      pt3_field_goals_made: g[10],
                      pt3_field_goals_attempted: g[11],
                      ft_made: g[12],
                      ft_attempted: g[13],
                      off_reb: g[14],
                      def_reb: g[15],
                      assists: g[16],
                      turnovers: g[17],
                      steals: g[18],
                      blocks: g[19],
                      fouls: g[20]
                    },
                    losing_stats: {
                      score: g[5],
                      field_goals_made: g[21],
                      field_goals_attempted: g[22],
                      pt3_field_goals_made: g[23],
                      pt3_field_goals_attempted: g[24],
                      ft_made: g[25],
                      ft_attempted: g[26],
                      off_reb: g[27],
                      def_reb: g[28],
                      assists: g[29],
                      turnovers: g[30],
                      steals: g[31],
                      blocks: g[32],
                      fouls: g[33]
                    })
    end
  end

  def self.stats_for_team(stats: [], team:)
    stats.select do |stat|
      stat.winning_team_id == team.id || stat.losing_team_id == team.id
    end
  end

  def self.avg_stats(stats: [], team_id:)
    totals = self.total_stats(stats: stats, team_id: team_id)
    totals.keys.reduce({}) do |memo, k|
      memo[k] = totals[k].to_f / stats.size
      memo
    end
  end

  def self.total_stats(stats: [], team_id:)
    stats.reduce({}) do |memo, stat|
      relevant_stats = {}
      if stat.winning_team_id == team_id
        relevant_stats = stat.winning_stats
      else
        relevant_stats = stat.losing_stats
      end

      relevant_stats.keys.each do |stat_key|
        memo[stat_key] ||= 0
        memo[stat_key] += relevant_stats[stat_key].to_i
      end

      memo
    end
  end
end

class GameStats
  attr_reader :winning_team_id, :losing_team_id, :location, :winning_stats, :losing_stats

  def initialize(winning_team_id:,
                 losing_team_id:,
                 location:,
                 winning_stats:,
                 losing_stats:)
    @winning_team_id = winning_team_id
    @losing_team_id = losing_team_id
    @location = location
    @winning_stats = winning_stats
    @losing_stats = losing_stats 
  end
end