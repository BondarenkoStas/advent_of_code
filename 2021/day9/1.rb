# filename = './try_input'
filename = './input'

lines = File.readlines(filename).map { |line| line.strip.split('').map(&:to_i) }
i_max = lines.length - 1
j_max = lines[0].length - 1
high_value = 10


min_values = []
lines.each_with_index do |row, i|
  row.each_with_index do |val, j|
    top = i > 0 && lines[i - 1][j] || high_value
    left = j > 0 && lines[i][j - 1] || high_value
    right = j < j_max && lines[i][j + 1] || high_value
    bottom = i < i_max && lines[i + 1][j] || high_value
    min_values.append(val) if [top, left, right, bottom].all? { |side| side > val }
  end
end

p min_values.reduce(0) { |sum, val| sum + val + 1 }