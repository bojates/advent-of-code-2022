def calculate_max_calories(filename)
  sum = 0
  max = 0

  File.foreach(filename) do |line| 
    sum += line.to_i
    
    if line =~ /^([^0-9]*)$/
      max = sum if sum > max
      sum = 0
    end
  end

  max
end

puts 'PASS' if calculate_max_calories('calories_test.txt') == 24000
puts calculate_max_calories('calories_test.txt') # 24000
puts ''
puts 'PASS' if calculate_max_calories('calories.txt') == 71502
puts calculate_max_calories('calories.txt')
