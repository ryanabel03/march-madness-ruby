class ConferenceRepo
  def self.get_conferences
    CSV.read("./data/TeamConferences.csv", headers: true).map { |r| TeamConference.new(team_id: r[1], conference_abbrev: r[2])}
  end

  def self.conference_for_team(conferences: [], team_id:)
    conferences.find { |c| c.team_id == team_id }
  end
end

class TeamConference
  attr_reader :team_id, :conference_abbrev
  def initialize(team_id:, conference_abbrev:)
  end
end