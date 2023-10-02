def item_priorities(filename)
  filename = File.dirname(__FILE__) + '/' + filename
  lines = File.readlines(filename, chomp: true)

  lines.map do |bag|
    half = bag.length / 2
    comp_1, comp_2 = bag[0, half].split(''), bag[half, half].split('')
    both_comps = comp_1.intersection(comp_2).first
    item_priority(both_comps)
  end.sum
end

def find_badge(filename)
  filename = File.dirname(__FILE__) + '/' + filename
  lines = File.readlines(filename, chomp: true)
  sum = 0
  
  lines.each_slice(3) do |elf_1, elf_2, elf_3|
    badge = elf_1.split('').intersection(elf_2.split(''), elf_3.split('')).first
    sum += item_priority(badge)
  end
  
  sum
end

def item_priority(item)
  letters = ('a'..'z').to_a + ('A'..'Z').to_a
  letters.index(item) + 1 || 0
end

def test(input, expected)
  if input == expected 
    puts "PASS: (#{input})"
  else
    puts '** FAIL **'
    puts "expected: #{expected}"
    puts "got: #{input}"
  end
  puts ""
end

test(item_priorities('rucksack_data_test.txt'), 157)
test(item_priorities('rucksack_data.txt'), 7701)
test(find_badge('rucksack_data_test.txt'), 70)
test(find_badge('rucksack_data.txt'), 2644)

=begin
# Problem version 2
Groups of three. Each elf carries the item. 
The three don't also all carry any other item. e.g. A could be in 1, and 2, but not in 3. But badge a would be in 1, 2, 3. 

Find the item that appears in each of the three rucksacks. 
Elves are in groups of three. As shown in the data. 

Find the priorities of the badges. 
Sum them. 

# Example
vJrwpWtwJgWrhcsFMMfFFhFp
jqHRNqRjqzjGDLGLrsFMfFZSrLrFZsSL
PmmdzqPrVvPwwTWBwg
wMqvLMZHhHMvwLHjbvcjnnSBnvTQFn
ttgJtRGJQctTZtZT
CrZsJsPPZsGzwwsLwLmpwMDw

Lines 1, 2, 3. 
Find the item that is in all three. 
r
Look up priority. 18. 

Lines 4, 5, 6
Find the item that is in all three. 

# Algo
Read the file. 
sum
create the letters
Into an array. 
lines = File.readlines("my_file.txt")
  Take three lines at a time each_slice(3)
    split each line into array
    elf_1, elf2_, elf_3 = grouping
    find intersection
    badge = elf_1.split('').intersection(elf_2.split(''), elf_3.split(''))
    find priority
    sum += letters.index(badge)

returm sum

=end
=begin
# Problem
Each rucksack: two large compartments
Item type identified by single lowercase or uppercase letter. A != a. 
All items of given type in exactly one of the two compartments. 


Same number of items in each compartment. 
First half of list = first compartment
second half = second compartment

Rule failed for one item type per racksack. 

To help rearrange items, every item type converted to priority. 
a..z => 1..26
A..Z => 27..52

For each rucksak, find the item type that appears in both compartments. 
What is the sum of the priorities of those item types? 

# Example
items: vJrwpWtwJgWrhcsFMMfFFhFp
comp 1: vJrwpWtwJgWr
comp 2: hcsFMMfFFhFp

Item type in both: p

# Data
a..z and A..Z don't map to ASCII codes. 

input: text. Series of strings to process. 
output: integer

letters to priorities - looks like an array

# Algorithm
Start a sum = 0
Open the file
Read each line
  split line in two, based on length (can be different lengths)
    trim
    get length
    split based on length (slice) or str[0,spl], str[spl]
    string.to_a
  find char in both strings 
    split into arrays and keep_if ? Or intersection? 
  look up 'priority'
    array with a-z and A-Z. Find index. Add 1.
    chars.index('item')
  add to sum
return sum

# Code

=end