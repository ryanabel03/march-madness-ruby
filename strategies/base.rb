require 'pry'
Dir.glob(__dir__ + '/..' + '/repositories/*.rb') { |f| require_relative f }

class Base
  def self.decide_winner(team_one:, team_two:)
    throw "implement me!"
  end
end