def calculate_max_calories(filename, number_elves = 1)
  filename = File.dirname(__FILE__) + "/" + filename
  # create an iterator to avoid loading the whole file into memory
  # but also so we can check for the end of the file as we loop
  lines = File.foreach(filename)

  totals = []
  sum = 0

  lines.each_with_index do |line, idx|
    sum += line.to_i
    if /^([^0-9]*)$/.match?(line)
      totals << sum
      sum = 0
    elsif idx == lines.count - 1
      totals << sum
    end
  end

  totals.sort!.reverse!
  totals.first(number_elves).sum
end

def test(calculation, expected)
  puts (calculation == expected) ? "PASS" : "FAIL"
  puts calculation
  puts ""
end

# Tests
test(calculate_max_calories("calories_test.txt"), 24000)
test(calculate_max_calories("calories_test2.txt"), 24000)
test(calculate_max_calories("calories.txt"), 71502)
test(calculate_max_calories("calories_test.txt", 3), 45000)
test(calculate_max_calories("calories_test2.txt", 3), 45000)

# Results
puts calculate_max_calories("calories.txt", 3)
