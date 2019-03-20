require 'csv'

class TournamentRepo
  def self.get_seeds
    CSV.read("./data/NCAATourneySeeds.csv", headers: true).map { |l| Seed.new(seed: l[1], team_id: l[2]) }
  end

  def self.get_matchups
    CSV.read("./data/NCAATourneySlots.csv", headers: true).map { |l| Matchup.new(id: l[1], slot_one_id: l[2], slot_two_id: l[3]) }
  end
end

class Seed
  attr_reader :seed, :team_id
  def initialize(seed:, team_id:)
    @seed = seed
    @team_id = team_id
  end

  def seed_int
    /.(\d{2})/.match(@seed)[1].to_i
  end

  def lower?(other_seed)
    seed_int < other_seed.seed_int
  end
end

class Matchup
  attr_reader :id, :slot_one_id, :slot_two_id
  def initialize(id:, slot_one_id:, slot_two_id:)
    @id = id
    @slot_one_id = slot_one_id
    @slot_two_id = slot_two_id
  end
end