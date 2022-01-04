# filename = './try_input'
filename = './input'

$lines = File.readlines(filename).map(&:to_s).map(&:chomp)

def line_score(line)
  pairs = {')' => '(', ']' => '[', '}' => '{', '>' => '<'}
  points = {')' => 3, ']' => 57, '}' => 1197, '>' => 25137}

  stack = []
  line.each_char do |char|
    if '{([<'.include?(char)
      stack.append(char)
    elsif '})]>'.include?(char) && stack[-1] == pairs[char]
      stack.pop
    else
      return points[char]
    end
  end
  nil
end

p $lines.map { |line| line_score(line) }.compact.sum
