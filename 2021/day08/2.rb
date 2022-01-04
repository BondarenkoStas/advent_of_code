require 'set'

content = File.readlines('./input').map(&:to_s).map(&:chomp)
# content = File.readlines('./try_input').map(&:to_s)

class Display
  def self.parse(input)
    patterns, numbers = input.split('|').map { _1.split(' ') }
    Display.new(patterns, numbers)
  end

  attr_reader :patterns, :numbers

  def initialize(patterns, numbers)
    @patterns = patterns.map { Set.new(_1.chars) }
    @numbers = numbers.map { Set.new(_1.chars) }
  end

  def simple_numbers
    numbers.count { [2, 3, 4, 7].include?(_1.length) }
  end

  def output_number
    numbers.map { mappings[_1] }.join.to_i
  end

  def mappings
    return @mapping if @mapping

    @mapping = {}
    one = patterns.find { _1.length == 2 }
    four = patterns.find { _1.length == 4 }

    patterns.each do |pattern|
      one_diff = (pattern - one).length
      four_diff = (pattern - four).length
      @mapping[pattern] = case [pattern.length, one_diff, four_diff]
      in [6, 4, 3]
        0
      in [2, _, _]
        1
      in [5, 4, 3]
        2
      in [5, 3, 2]
        3
      in [4, _, _]
        4
      in [5 , 4, 2]
        5
      in [6, 5, _]
        6
      in [3, _, _]
        7
      in [7, _, _]
        8
      in [6, 4, 2]
        9
      end
    end
    @mapping
  end
end

displays = content.map { |line| Display.parse(line) }
p displays.inject(0) {|a, d| a + d.output_number}
