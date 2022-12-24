INPUT = File.readlines('day04.txt').map do |line|
    line.chomp.split(',').map do |r| 
        Range.new(*r.split('-').map(&:to_i))
    end
end

puts 'Part 1'

puts INPUT.count { |r1, r2| r1.cover?(r2) || r2.cover?(r1) } 

puts 'Part 2'

cnt = INPUT.count do |r1, r2| 
    r1.include?(r2.begin) || 
        r1.include?(r2.end) || 
        r2.include?(r1.begin) || 
        r2.include?(r1.end)
end

puts cnt