class RPS
  CODE_TO_PLAY = { 'A' => 'rock', 'B' => 'paper', 'C' => 'scissors' }
  CODE_TO_RESULT = { 'X' => 'lose', 'Y' => 'draw', 'Z' => 'win' }
  PLAY_SCORE = { 'rock' => 1, 'paper' => 2, 'scissors' => 3 }
  RESULT_SCORE = { 'lose' => 0, 'draw' => 3, 'win' => 6 }

  def self.play_series(filename)
    filename = File.dirname(__FILE__) + '/' + filename
    lines = File.foreach(filename)
    total_score = 0
    
    lines.each do |line| 
      their_play, desired_result = decode_line(line)
      total_score += RESULT_SCORE.fetch(desired_result)
      total_score += PLAY_SCORE.fetch(my_play(their_play, desired_result))
    end

    total_score
  end

  private 

  def self.my_play(their_play, desired_result)
    ['rock', 'paper', 'scissors'].each do |play|
      return play if single_play(their_play, play) == desired_result
    end
  end

  def self.decode_line(line)
    _, player_1, result = *line.match(/([ABC])\s([XYZ])/)
    [CODE_TO_PLAY.fetch(player_1), CODE_TO_RESULT.fetch(result)]
  end

  def self.single_play(their_play, my_play)
    case their_play
    when 'rock'
      return 'draw' if my_play == 'rock'
      return 'win' if my_play == 'paper'
      return 'lose' if my_play == 'scissors'
    when 'paper'
      return 'lose' if my_play == 'rock'
      return 'draw' if my_play == 'paper'
      return 'win' if my_play == 'scissors'
    when 'scissors'
      return 'win' if my_play == 'rock'
      return 'lose' if my_play == 'paper'
      return 'draw' if my_play == 'scissors'
    end
  end

end

def run_test(test_result, expected)
  puts test_result == expected ? 'PASS' : '** FAIL ** '
  puts 'result: ' + test_result.to_s
  puts 
end

run_test(RPS.play_series('strategy_guide_test.txt'), 12)
run_test(RPS.play_series('strategy_guide.txt'), 14652)