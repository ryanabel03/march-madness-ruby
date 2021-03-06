require 'csv'

class TeamRepo
  def self.get_teams
    CSV.read("./data/Teams.csv", headers: true).map { |a| Team.new(id: a[0], name: a[1])}
  end

  def self.find_by_seed(teams: [], seed_id:)
    teams.find { |t| t.seed&.seed == seed_id }
  end

  def self.find_from_results(results: [], slot_id: )
    results.find { |r| r.slot_id == slot_id }.winning_team
  end
end

class Team
  attr_reader :id, :name
  attr_accessor :seed, :stats
  def initialize(id:, name:)
    @id = id
    @name = name
    @seed = nil
  end

  def stat_averages
    @averages ||= StatsRepo.avg_stats(stats: @stats, team_id: @id)
    @averages
  end

  def wins
    @wins ||= StatsRepo.wins(stats: @stats, team_id: @id)
  end

  def losses
    @losses ||= StatsRepo.losses(stats: @stats, team_id: @id)
  end

  def find_conference(conferences: [])
    @conference ||= ConferenceRepo.conference_for_team(conferences: conferences, team_id: @id)
  end
end