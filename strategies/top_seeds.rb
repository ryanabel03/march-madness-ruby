require 'pry'
require_relative '../results_formatter.rb'
require_relative './base.rb'
Dir.glob(__dir__ + '/..' + '/repositories/*.rb') { |f| require_relative f }

class TopSeedStrategy < Base
  def self.decide_winner(team_one:, team_two:)
    team_one.seed.lower?(team_two.seed) ? [team_one, team_two] : [team_two, team_one]
  end
end

teams = TeamRepo.get_teams
tournament_seeds = TournamentRepo.get_seeds
tournament_teams = tournament_seeds.reduce([]) do |memo, seed|
  team = teams.find { |t| t.id == seed.team_id }
  if team
    team.seed = seed
    memo << team
  end
  memo
end

matchups = TournamentRepo.get_matchups

results = []
matchups.each do |matchup|
  team_one = TeamRepo.find_by_seed(teams: tournament_teams, seed_id: matchup.slot_one_id)
  team_two = TeamRepo.find_by_seed(teams: tournament_teams, seed_id: matchup.slot_two_id)

  team_one ||= TeamRepo.find_from_results(results: results, slot_id: matchup.slot_one_id)
  team_two ||= TeamRepo.find_from_results(results: results, slot_id: matchup.slot_two_id)

  winner, loser = TopSeedStrategy.decide_winner(team_one: team_one, team_two: team_two)

  results << Result.new(slot_id: matchup.id, team_one: team_one, team_two: team_two, winning_team: winner)
end

ResultsFormatter.format_and_print(results: results)