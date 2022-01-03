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
end

displays = content.map { |line| Display.parse(line) }
p displays.inject(0) {|a, d| a + d.simple_numbers}
