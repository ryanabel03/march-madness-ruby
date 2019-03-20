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
  attr_accessor :seed
  def initialize(id:, name:)
    @id = id
    @name = name
    @seed = nil
  end
end