require 'set'
SCORES = ([*'a'..'z'] + [*'A'..'Z']).zip(1..52).to_h

INPUT = File.readlines('day03.txt').map(&:chomp)

puts "Part 1"

sum = INPUT.sum do |rucksack|
    comp1, comp2 = rucksack[0...rucksack.length / 2], rucksack[rucksack.length / 2..-1]
    common_char = Set.new(comp1.chars).intersection(comp2.chars).to_a[0]
    SCORES[common_char]
end

puts sum

puts "Part 2"
sum2 = INPUT.each_slice(3).sum do |sacks|
    sack1, sack2, sack3 = sacks.map { |sack| Set.new(sack.chars) }
    common_char = sack1.intersection(sack2).intersection(sack3).to_a[0]
    SCORES[common_char]
end

puts sum2