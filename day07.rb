require 'set'

class Dir
    attr_accessor :files, :parent, :name
    def initialize(name:, parent:)
        self.parent = parent
        self.name = name
        self.files = {}
    end

    def add_file(file)
        self.files[file.name] ||= file
    end

    def get(file)
        file.is_a?(String) ? self.files[file] : self.files[file.name]
    end

    def path
        return '' if parent.nil?
        parent.path + '/' + name
    end

    def inspect
        parent.nil? ? name : path
    end

    def subdirectories
        files.values.select { |f| f.is_a?(Dir) }
                    .map { |dir| [dir, dir.subdirectories] }
                    .flatten
    end

    def size
        direct_size = files.values.select { |f| f.is_a?(Filler) }.sum(&:size)
        subdirectory_size = files.values.select { |f| f.is_a?(Dir) }.sum { |d| d.size }
        direct_size + subdirectory_size
    end
end
Filler = Struct.new(:size, :parent, :name, keyword_init: true)

lines = File.readlines('day07.txt').map(&:chomp).drop(1)
root = Dir.new(name: '/', parent: nil)
current = root

until lines.empty? do
    cmd = lines.shift
    case
    when cmd.start_with?('$ ls')
        until lines.empty? || lines.first.start_with?('$')
            line = lines.shift
            new_file = if line.start_with?('dir')
                Dir.new(name: line.gsub('dir ', ''), parent: current)
            else
                size, name = line.split
                Filler.new(size: size.to_i, name: name, parent: current)
            end
            current.add_file(new_file)
        end
    when cmd == '$ cd ..'
        current = current.parent
    when cmd.start_with?('$ cd')
        dir = Dir.new(name: cmd.gsub('$ cd ', ''), parent: current)
        current.add_file(dir)
        current = current.get(dir)
    else
        raise "#{cmd}, wtf is that?"
    end
end

puts 'Part 1'
puts root.subdirectories.map(&:size).select { |s| s <= 100000 }.sum

puts 'Part 2'
TOTAL_SPACE = 70000000
NEEDED_SPACE = 30000000
unused_space = TOTAL_SPACE - root.size
diff = NEEDED_SPACE - unused_space

puts root.subdirectories.map(&:size).select { |s| s > diff }.min

