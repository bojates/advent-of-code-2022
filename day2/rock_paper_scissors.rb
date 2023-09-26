=begin
# Problem
  Rock Paper Scissors
  Multiple rounds
  rock > scissors
  scissors > paper
  paper > rock

  Strategy guide
  first column: opponent
  second column: proposed play <- I care about this player winning
  
  Them: 
  A = rock
  B = paper
  C = scissors

  Me
  X = rock
  Y = paper
  Z = scissors

  Total score is sum of rounds.
  Single round is shape + outcome
  1 = rock (X)
  2 = paper (Y)
  3 = scissors (Z)
  plus
  0 = lost
  3 = draw
  6 = won

# Example
A Y
B X
C Z

Rock vs Paper. I win. Paper = 2, win = 6, total 8. 
Paper vs rock. Lose. 1. 
Scissors vs scissors. Draw. 3 + 3. 6. 
Total: 15

# Data
Input: puzzle guide. Text format. One round per line. Space separated plays. 
?? Handle bad input? 
Check we are including the last line. 
Output: single score. 

# Algorithm
Start a score of 0
Constants
  RPS { 'X' => 'rock', etc.}
  PLAY_SCORE { 'rock' => 1, etc. }
  RESULT_SCORE = { 'win' => 6, etc. }

Read the strategy guide. 
  - open file
  - create an iterator
  - loop through the file
For each line: 
  calculate the result (win, lose, draw)
    - split the line using the space? Probably better use regexp to grab ABC or XYZ
    - round_result(them, me) returns (win, lose, draw)
    - win / lose / draw score + my_play_score
  add to a total score
Return the score. 

round_result(their play, my_play)
  switch their_play
  rock
    my_play == rock
      draw
    my_play == paper
      win
    my_play == scissors
      lose
  paper
    my_play == rock
      lose
    my_play == paper
      draw
    my_play == scissors
      win
  scissors
    my_play == rock
      win
    my_play == paper
      lose
    my_play == scissors
      draw

=end

class RPS
  CODE_TO_WORD = { 'A' => 'rock', 'B' => 'paper', 'C' => 'scissors', 
                  'X' => 'rock', 'Y' => 'paper', 'Z' => 'scissors', }
  PLAY_SCORE = { 'rock' => 1, 'paper' => 2, 'scissors' => 3 }
  RESULT_SCORE = { 'win' => 6, 'lose' => 0, 'draw' => 3 }

  def self.play_series(filename)
    filename = File.dirname(__FILE__) + '/' + filename
    lines = File.foreach(filename)
    total_score = 0
    
    lines.each do |line| 
      them, me = get_plays(line)
      total_score += PLAY_SCORE.fetch(me)
      total_score += RESULT_SCORE.fetch(single_play(them, me))
    end

    total_score
  end

  def self.get_plays(line)
    _, player_1, player_2 = *line.match(/([ABC])\s([XYZ])/)
    [CODE_TO_WORD.fetch(player_1), CODE_TO_WORD.fetch(player_2)]
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

# puts RPS.play_series('strategy_guide_test.txt')

run_test(RPS.play_series('strategy_guide_test.txt'), 15)
run_test(RPS.play_series('strategy_guide.txt'), 0)