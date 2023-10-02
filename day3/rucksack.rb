def item_priorities(filename)
  filename = File.dirname(__FILE__) + '/' + filename
  lines = File.foreach(filename)
  letters = ('a'..'z').to_a + ('A'..'Z').to_a

  lines.map do |line|
    half = line.length / 2
    comp_1, comp_2 = line[0, half].split(''), line[half, half].split('')
    intersection = comp_1.intersection(comp_2).first
    letters.index(intersection) + 1 if letters.index(intersection)
  end.sum
end

def test(input, expected)
  puts input == expected ? 'PASS' : '** FAIL **'
  puts "expected: #{expected}"
  puts "got: #{input}"
end

test(item_priorities('rucksack_data_test.txt'), 157)
test(item_priorities('rucksack_data.txt'), 7701)


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