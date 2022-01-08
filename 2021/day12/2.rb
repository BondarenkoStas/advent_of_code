require 'set'

def solution(filename)
  edges = Hash.new{|k, v| k[v] = Set.new}
  File.read(filename).split($/).each do |line|
    src, dst = line.split('-')
    edges[src].add(dst)
    edges[dst].add(src)
  end

  all_paths = Set.new
  todo = [[['start'], false]]
  until todo.empty?
    path, double_cave = todo.pop

    if path[-1] == 'end'
      all_paths.add(path)
    else
      edges[path[-1]].each do |dst|
        next if dst == 'start'
        todo.append([[*path, dst], double_cave]) unless dst == dst.downcase && path.include?(dst)
        todo.append([[*path, dst], true]) if not double_cave && path.include?(dst)
      end
    end
  end
  all_paths.size
end

# p solution('try_input')
p solution('input')
