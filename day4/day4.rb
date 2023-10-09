# Problem:
#   Elves are allocated a range of spaces.
#   The elves pair up and compare the ranges they've been allocated.
#   We need to find ranges that are entirely encompased by their partner range.
#   We get an input of pairings
#   We need to return an output of a number of how many pairs where one range is contained by the other.
#   Example shows small ranges and numbers, but real data can be larger.
#
# Example:
#   2-4,6-8
#   2-3,4-5
#   5-7,7-9
#   2-8,3-7
#   6-6,4-6
#   2-6,4-8
#
# Pair 1: Elf 1 has 2-4 (2, 3, 4), Elf 2 has 6-8 (6, 7, 8). No overlap.
# Pair 3: Elf 1 has 5-7 (5, 6, 7), Elf 2 has 7-9 (7, 8, 9). One overlap.
# Pair 5: Elf 1 has 6-6 (6), Elf 2 has 4-6 (4, 5, 6). Elf 1 totally encompassed by Elf 2.
#
# Data:
#   Input: File with strings of number pairs, one pair per line, comma separated. Range indicated with '-'
#
#   Output: count
#
# Alg:
#   Set up counter
#   Read the file
#   Take each pair
#     split into elves (split on comma)
#     create the ranges for each
#       split on - and create a range (r[0]..r[1])
#     compare ranges.
#       delete one from the other? If one is empty, we have a hit?
#       find intersections and if intersections count == size of the smallest array, we have a hit
#     Grab the numbers. Sort so the lower number is on the left. Then compare higher numbers.
#     add to counter if one encompassed by other
#
#   return count

def test(result, expected)
  if result == expected
    puts "OK: (#{result})"
  else
    puts "FAIL"
    puts "Got: #{result}"
    puts "Expected: #{expected}"
  end
  puts ""
end

def find_complete_overlaps(filename)
  filename = File.dirname(__FILE__) + "/" + filename
  lines = File.readlines(filename, chomp: true)

  lines.count do |line|
    elf1, elf2 = ranges_pair(line)

    elf1.intersection(elf2).length == [elf1.length, elf2.length].min
  end
end

def find_any_overlaps(filename)
  filename = File.dirname(__FILE__) + "/" + filename
  lines = File.readlines(filename, chomp: true)

  lines.count do |line|
    elf1, elf2 = ranges_pair(line)

    elf1.intersection(elf2).length.nonzero?
  end
end

def ranges_pair(line)
  line.split(",").map do |item|
    first, second = item.split("-")
    (first..second).to_a
  end
end

test(find_complete_overlaps("data_test.txt"), 2)
test(find_complete_overlaps("data.txt"), 562)
# Part 2
test(find_any_overlaps("data_test.txt"), 4)
test(find_any_overlaps("data.txt"), 924)
