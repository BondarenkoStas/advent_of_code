require 'set'

# Solution from ruby https://github.com/ttilberg/advent-of-code-2021-rb/blob/main/2021/12/1.rb

def get_paths(filename)
  paths = File.read(filename).split($/).map{|line| line.split('-')}

  start_paths = paths.select{|here, there| here =~ /start/}
  end_paths = paths.select{|here, there| there =~ /end/}
  mid_paths = paths - (start_paths + end_paths)
  paths + mid_paths.map{|here, there| [there, here]}
end

def explore(route, paths=[])
  route = Array(route)
  node = route.last
  return route if node == 'end' || paths.empty?

  options = paths.select{|here, there| here == node}
  return route if options.empty?

  paths -= paths.select {|here, there| here == node} if node =~ /[a-z]+/

  options.map {|here, there| explore(route + [there], paths)}
end

def untangle_routes(routes, fixed_routes=[])
  routes.each do |route|
    if route&.first.is_a? Array
      fixed_routes += untangle_routes(route)
    else
      fixed_routes += [route]
    end
  end
  fixed_routes
end

def solution1(filename)
  paths = get_paths(filename)
  routes = explore('start', paths)
  routes = untangle_routes(routes)
  routes.select{|route| route.last == 'end'}.size
end

# Solution from python https://www.youtube.com/watch?v=dlPoe04FoQk

# ---------------- Iterative

def solution2(filename)
  edges = Hash.new{|k, v| k[v] = Set.new}
  File.read(filename).split($/).each do |line|
    src, dst = line.split('-')
    edges[src].add(dst)
    edges[dst].add(src)
  end

  all_paths = Set.new
  todo = [['start']]
  until todo.empty?
    path = todo.pop

    if path[-1] == 'end'
      all_paths.add(path)
    else
      edges[path[-1]].each do |dst|
        unless dst == dst.downcase && path.include?(dst)
          todo.append([*path, dst])
        end
      end
    end
  end
  all_paths.size
end

# --------------- Recursive

def solution3(filename)
  $connected_caves = Hash.new{|k, v| k[v] = Set.new}
  File.read(filename).split($/).each do |line|
    from, to = line.split('-')
    $connected_caves[from].add(to)
    $connected_caves[to].add(from)
  end
  get_paths_1(Set.new, [['start']]).size
end

def get_paths_1(all_paths, paths_todo)
  return all_paths if paths_todo.empty?

  path = paths_todo.pop
  last_cave = path[-1]

  all_paths += [path] if last_cave == 'end'
  paths_todo += $connected_caves[last_cave]
    .reject { |dst| 
      dst == dst.downcase && path.include?(dst) 
    }.map { |to| 
      [*path, to] 
    } unless last_cave == 'end'

  get_paths_1(all_paths, paths_todo)
end

# --------------- Recursive 2

def solution4(filename)
  $connected_caves = Hash.new{|k, v| k[v] = Set.new}
  File.read(filename).split($/).each do |line|
    from, to = line.split('-')
    $connected_caves[from].add(to)
    $connected_caves[to].add(from)
  end
  $solutions = []
  get_paths_2(['start'])
  $solutions.length
end

def get_paths_2(path)
  return $solutions.append(path) if path[-1] == 'end'

  $connected_caves[path[-1]].reject { |to| 
    to == to.downcase && path.include?(to)
  }.each { |to| 
    get_paths_2([*path, to])
  }
end

def res_and_time(function, *args)
  t1 = Time.now
  res = method(function).call(*args)
  p "answer: #{res}, time: #{Time.now - t1}"
end

# Recursive functions are too deep for actual input

# [:solution1, :solution2, :solution3, :solution4].each {|f| res_and_time(f, 'input')}
[:solution1, :solution2].each {|f| res_and_time(f, 'input')}
