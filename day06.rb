puts 'Part 1'

INPUT = File.read('day06.txt').chomp

def find_message_end(str, len)
    str.chars.each_cons(len).with_index do |(*arr), i|
        return i + len if [*arr].uniq.length == len
    end
end

puts find_message_end(INPUT, 4)

puts 'Part 2'

puts find_message_end(INPUT, 14)