# Part 1

elves = File.read('day01.txt')
            .split("\n\n")
            .map { |chunk| chunk.lines.map(&:to_i) }

puts elves.max_by(&:sum).sum

# Part 2

puts elves.max_by(3, &:sum).flatten.sum


