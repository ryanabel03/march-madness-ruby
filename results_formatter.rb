class ResultsFormatter
  def self.format_and_print(results: [])
    rounds = results.group_by { |r| r.round_number }

    round_keys = rounds.keys.reject { |k| k == "0" }

    round_names = {"1" => "Round of 64", "2" => "Round of 32", "3" => "Sweet Sixteen", "4" => "Elite Eight", "5" => "Final Four", "6" => "National Championship"}

    round_keys.each do |r|
      puts "----------------------------------------"
      puts "#{round_names[r].upcase}"
      puts "----------------------------------------"
      puts "\n"

      rounds[r].each do |result|
        puts "#{result.team_one.name}"
        puts "\t\t#{result.winning_team.name}"
        puts "#{result.team_two.name}"
        puts "\n"
        puts "\n"
      end
    end
  end
end