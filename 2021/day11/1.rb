require 'set'

filename = './try_input'
# filename = './input'

lines = File.readlines(filename).map(&:to_s).map(&:chomp).map { |line| line.split('').map(&:to_i) }

class Octopuses
  def initialize(octopuses)
    @flash_count = 0
    @flashed_this_step = 0
    @max_level = 9
    @octopuses = octopuses
    @i_max = octopuses.length - 1
    @j_max = octopuses[0].length - 1
  end

  def should_flash_now
    @octopuses.each_with_index.map do |row, i|
      row.each_with_index.map do |val, j|
        val > @max_level ? [i, j] : nil
      end
    end.flatten(1).compact
  end

  def increment_neighbors(i, j)
    ([0, i - 1].max .. [@i_max, i + 1].min).each do |_i|
      ([0, j - 1].max .. [@j_max, j + 1].min).each do |_j|
        @octopuses[_i][_j] += 1 if !(@flashed_this_step === [_i, _j])
      end
    end
  end

  def next_step
    (0..@i_max).each { |i| (0..@j_max).each { |j| @octopuses[i][j] += 1 } }
    @flashed_this_step = Set.new
    until next_substep.empty?; end
    @flash_count += @flashed_this_step.length
  end

  def next_substep
    indices_to_flash = should_flash_now
    @flashed_this_step += indices_to_flash
    indices_to_flash.each do |(i, j)|
      @octopuses[i][j] = 0
      increment_neighbors(i, j)
    end
  end

  def do_steps_and_get_flash_count(n)
    n.times { next_step }
    @flash_count
  end
end

octo = Octopuses.new(lines)
p octo.do_steps_and_get_flash_count(100)
