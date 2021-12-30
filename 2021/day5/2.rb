content = File.readlines('./input').map(&:to_s)
# content = File.readlines('./try_input').map(&:to_s)

class Line
    attr_accessor :points

    def initialize(input)
        @points = []
        x1, y1, x2, y2 = input.strip.split(' -> ').map{ |pair| pair.split(',').map(&:to_i)}.flatten
        step_x = x2 >= x1 ? 1 : -1
        step_y = y2 >= y1 ? 1 : -1
        if y1 == y2
            @points += (x1..x2).step(step_x).map{ |x| [x, y1]}
        elsif x1 == x2
            @points += (y1..y2).step(step_y).map{ |y| [x1, y]}
        elsif (x1 - x2).abs == (y1 - y2).abs
            @points += (x1..x2).step(step_x).zip((y1..y2).step(step_y))
        end
    end

    def empty?
        @points.empty?
    end
end

def get_lines(content)
    content.map { |input_line| Line.new(input_line) } .reject(&:empty?)
end

def solve(content)
    map = {}
    get_lines(content).each do |line|
        line.points.each {|point| map[point] = (map[point] || 0) + 1}
    end
    map.values.select {|count| count > 1}.count
end

p solve(content)
