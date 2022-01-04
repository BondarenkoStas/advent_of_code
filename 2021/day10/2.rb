# filename = './try_input'
filename = './input'

$lines = File.readlines(filename).map(&:to_s).map(&:chomp)

def correct_line(line)
  pairs = {')' => '(', ']' => '[', '}' => '{', '>' => '<'}
  opposite_pairs = {'(' => ')', '[' => ']', '{' => '}', '<' => '>'}
  points = {')' => 1, ']' => 2, '}' => 3, '>' => 4}

  stack = []
  line.each_char do |char|
    if '{([<'.include?(char)
      stack.append(char)
    elsif '})]>'.include?(char) && stack[-1] == pairs[char]
      stack.pop
    else
      return nil
    end
  end

  completion_line = stack.reverse.map { |char| opposite_pairs[char]}
  completion_line.reduce(0) { |sum, char| sum * 5 + points[char] }
end

points = $lines.map { |line| correct_line(line) }.compact.sort
p points[points.length / 2]
