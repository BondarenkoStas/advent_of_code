require 'set'
require './min_heap.rb'

# idea of the solution is taken from https://youtu.be/vRWiqHEfcy8

class Solution
  def initialize(lines)
    @lines = lines
    @max_i = lines.length - 1
    @max_j = lines[0].length - 1
    @queue = MinHeap.new(lambda { |a, b| a[0] < b[0] })
    @queue << [0, [0, 0]]
    @locked = Set.new
  end

  def get_neighbors(i, j)
    [[i + 1, j], [i - 1, j], [i, j + 1], [i, j - 1]]
      .select { |_i, _j| _i >= 0 && _i <= @max_i && _j >= 0 && _j <= @max_j }
  end

  def calculate_risk
    while @queue.length > 0
      risk, position = @queue.pop
      return risk if position == [@max_i, @max_j]

      unless @locked === position
        @locked.add(position)
        get_neighbors(*position).each { |i, j| @queue << [risk + @lines[i][j], [i, j]] }
      end
    end
  end
end

def part2(lines)
  max_i = lines.length
  max_j = lines[0].length
  new_lines = Array.new(max_i * 5) { Array.new(max_j * 5, 0) }
  (0...max_i * 5).each do |i|
    (0...max_j * 5).each do |j|
      new_lines[i][j] = lines[i % max_i][j % max_j] + i / max_i + j / max_j
      new_lines[i][j] -= 9 if new_lines[i][j] > 9
    end
  end
  new_lines
end

filename = 'input'
lines = File.readlines(filename).map(&:chomp).map{|line| line.split('').map(&:to_i) }
solution = Solution.new(part2(lines))
p solution.calculate_risk