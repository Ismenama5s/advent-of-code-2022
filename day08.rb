INPUT = File.readlines('day08.txt')

def generate_grid
    INPUT.map { |line| line.chomp.chars.map(&:to_i) }
end

def map_row(row)
    biggest_so_far = -1
    row.map do |el|
        flag = el > biggest_so_far
        biggest_so_far = [biggest_so_far, el].max
        flag
    end
end

LEFT_MAP = generate_grid.map { |row| map_row(row) }

RIGHT_MAP = generate_grid.map { |row| map_row(row.reverse).reverse }

UP_MAP = generate_grid.transpose
                      .map { |row| map_row(row) }
                      .transpose

DOWN_MAP = generate_grid.transpose
                        .map { |row| map_row(row.reverse).reverse }
                        .transpose

puts 'Part 1'

FINAL_MAP = LEFT_MAP.map.with_index do |row, i|
    row.map.with_index do |el, j|
        LEFT_MAP[i][j] || RIGHT_MAP[i][j] || UP_MAP[i][j] || DOWN_MAP[i][j]
    end
end

puts FINAL_MAP.map { |row| row.select(&:itself).count }.sum

puts 'Part 2'

# Memoize every cell in these maps with the distance 
# (from the direction intended) to the nearest 1, 2, 3, 4, 5
# So each cell is an array of length 10, so you have local memory
# This allows you to use dynamic programming from each slot