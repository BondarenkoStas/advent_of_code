require 'set'

# filename = './try_input'
filename = './input'

$lines = File.readlines(filename).map { |line| line.strip.split('').map(&:to_i) }
$i_max = $lines.length - 1
$j_max = $lines[0].length - 1
$high_value = 10

$already_marked = Set.new

def grow_basin(i, j)
  return 0 if i < 0 || j < 0 || i > $i_max || j > $j_max
  return 0 if $already_marked === [i, j] || $lines[i][j] == 9
  
  $already_marked.add([i, j])
  1 + grow_basin(i - 1, j) + grow_basin(i, j - 1) + grow_basin(i, j + 1) + grow_basin(i + 1, j)
end

basins = []
$lines.each_with_index.map do |row, i|
  row.each_with_index do |val, j|
    basins.append(grow_basin(i, j)) if [
        *($lines[i - 1][j] if i > 0), 
        *($lines[i][j - 1] if j > 0), 
        *($lines[i][j + 1] if j < $j_max),
        *($lines[i + 1][j] if i < $i_max)
      ].all? { |side| side > val }
  end
end

p basins.sort.last(3).inject(:*)
