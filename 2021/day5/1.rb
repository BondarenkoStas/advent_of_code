content = File.readlines('./input').map(&:to_s)
# content = File.readlines('./try_input').map(&:to_s)

class Line
  attr_accessor :points

  def initialize(input)
    @points = []
    horizontal, vertical = input.strip.split(' -> ').map{ |pair| pair.split(',').map(&:to_i)}.transpose
    x1, x2 = horizontal.min, horizontal.max
    y1, y2 = vertical.min, vertical.max
    if y1 == y2
      (x1..x2).each { |x| @points.append([x, y1])}
    elsif x1 == x2
      (y1..y2).each { |y| @points.append([x1, y])}
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
