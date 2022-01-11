class Solution
  def initialize(filename)
    polymer, rules = File.read(filename)
      .split("\n\n")
      .map{ |x| x.split("\n") }

    @count_letters = Hash.new{ |k, v| k[v] = 0 }
    @pairs = Hash.new{ |k, v| k[v] = 0 }

    polymer[0]
      .chars
      .each_cons(2)
      .to_a
      .map(&:join)
      .each { |pair| @pairs[pair] += 1 }

    polymer[0]
      .chars
      .each { |char| @count_letters[char] += 1 }

    @rules = rules
      .map { |rule| rule.split(' -> ') }
      .to_h
  end

  def step
    new_pairs = @pairs.dup
    @pairs.each do |pair, count|
      new_letter = @rules[pair]
      if new_letter
        new_pairs[pair] -= count
        new_pairs[pair[0] + new_letter] += count
        new_pairs[new_letter + pair[1]] += count
        @count_letters[new_letter] += count
      end
    end
    @pairs = new_pairs
  end

  def run_steps(n)
    n.times { step }
  end

  def answer
    @count_letters.values.max - @count_letters.values.min
  end
end

solution = Solution.new('input')
solution.run_steps(40)
p solution.answer
