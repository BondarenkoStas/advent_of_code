def read_input(filename)
  File.readlines(filename)[0].split(',').map(&:to_i)
end

def median(array)
  middle = array.size/2
  sorted = array.sort_by{ |a| a }
  sorted[middle]
end

array = read_input('./input')
# array = read_input('./try_input')

target = median(array)
p array.reduce(0) { |cost, pos| cost + (pos - target).abs }