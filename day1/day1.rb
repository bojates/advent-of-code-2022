def calculate_max_calories(filename, number_eleves = 1)
  filename = File.dirname(__FILE__) + '/' + filename
  
  totals = []
  sum = 0
  
  File.foreach(filename) do |line| 
    sum += line.to_i

    if line =~ /^([^0-9]*)$/
      totals << sum
      sum = 0
    elsif line == File.readlines(filename).last
      totals << sum 
    end

  end

  totals.sort!.reverse!
  totals.first(number_eleves).sum
end

def test(calculation, expected)
  puts calculation == expected ? 'PASS' : 'FAIL'
  puts calculation
  puts ''
end

# Tests
test(calculate_max_calories('calories_test.txt'), 24000)
test(calculate_max_calories('calories.txt'), 71502)
test(calculate_max_calories('calories_test.txt', 3), 45000)

# Results
puts calculate_max_calories('calories.txt', 3) 

