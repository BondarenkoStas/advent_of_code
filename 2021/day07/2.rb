def read_input(filename)
  File.readlines(filename)[0].split(',').map(&:to_i)
end

def progression(n)
  (n * (n + 1)) / 2
end

def get_cost(array, target)
  array.reduce(0) { |cost, pos| cost + progression((pos - target).abs) }
end

def solve(array)
  raw_target = array.sum(0.0) / array.size
  [raw_target.floor, raw_target.ceil].map { |target| get_cost(array, target) }.min  
end
  
array = read_input('./input')
# array = read_input('./try_input')

p solve(array)