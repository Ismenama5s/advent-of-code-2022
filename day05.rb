STACKS = Array.new(9) { [] }

puts 'Part 1'

def build_stacks
    stacks = Array.new(9) { [] }
    lines = File.readlines('day05.txt').map(&:chomp)
    until lines[0].start_with?(' 1')
        line = lines.shift
        crates = line.chars.each_slice(4).map { |s| s[1].strip }
        stacks.each_with_index do |stack, i|
            stack << crates[i] unless crates[i].empty?
        end
    end
    [stacks, lines.drop(2)]
end

stacks, instructions = build_stacks

until instructions.empty?
    line = instructions.shift
    count, from, to = line.gsub(/[a-z]/, '').split.map(&:to_i)
    count.times { stacks[to - 1].unshift(stacks[from - 1].shift) }
end

puts stacks.map(&:first).join

puts 'Part 2'

stacks, instructions = build_stacks
until instructions.empty?
    line = instructions.shift
    count, from, to = line.gsub(/[a-z]/, '').split.map(&:to_i)
    workspace = []
    count.times { workspace << stacks[from - 1].shift }
    count.times { stacks[to - 1].unshift(workspace.pop) }
end

puts stacks.map(&:first).join