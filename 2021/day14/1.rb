class Solution
  def initialize(filename)
    polymer, rules = File.read(filename)
      .split("\n\n")
      .map{ |x| x.split("\n") }

    @polymer = polymer[0]
    @rules = rules
      .map { |rule| rule.split(' -> ') }
      .map { |k, v| [k, k.dup.insert(1, v)] }
      .to_h
  end

  def step
    @polymer = @polymer[0] + @polymer
      .chars
      .each_cons(2)
      .to_a.map(&:join)
      .map{|k| (@rules[k] || k)[-2..] }
      .join
  end

  def run_steps(n)
    n.times { step }
  end

  def answer
    letters = Hash.new{|k, v| k[v] = 0}
    @polymer.chars.each { |char| letters[char] += 1 }
    letters.values.max - letters.values.min
  end
end

solution = Solution.new('input')
solution.run_steps(10)
p solution.answer
