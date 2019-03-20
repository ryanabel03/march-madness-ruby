class Result
  attr_reader :slot_id, :team_one, :team_two, :winning_team
  def initialize(slot_id:, team_one:, team_two:, winning_team:)
    @slot_id = slot_id
    @team_one = team_one
    @team_two = team_two
    @winning_team = winning_team
  end

  def round_number
    /R(\d).*/.match(@slot_id)[1]
  end
end