class Solution
  def initialize(filename)
    dots, instructions = File.read(filename)
      .split("\n\n")
      .map{ |x| x.split("\n") }

    dots.map! { |line| 
      line.split(',').map(&:to_i) }

    @instructions = instructions
      .map { |x| x.split('=') }
      .map { |left, right| [left[-1] == 'y', right.to_i] }

    @i_max = dots.map{ |x, y| y}.max
    @j_max = dots.map{ |x, y| x}.max
    @dots = Array.new(@i_max + 1) {Array.new(@j_max + 1, false)}
    dots.each {|x, y| @dots[y][x] = true}
  end

  def fold(dots, value)
    part1, part2 = [dots[...value], dots[value + 1..]]
    part1, part2 = [part2, part1] if part2.length > part1.length
    part2.reverse!
    offset = part1.length - value
    part1.each_with_index.map { |row, i|
      row.each_with_index.map { |val, j| 
        val || part2[offset + i][j] } }
  end

  def run_instruction(fold_y, value)
    @dots = fold_y ? fold(@dots, value) : fold(@dots.transpose, value).transpose
  end

  def run_instructions(n_first = @instructions.length)
    @instructions[...n_first].each {|fold_y, value| run_instruction(fold_y, value) }
  end

  def count_dots
    @dots.flatten.select(&:itself).count
  end
end

s = Solution.new('input')
s.run_instructions(1)
p s.count_dots


