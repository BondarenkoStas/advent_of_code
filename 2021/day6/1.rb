def read_input(filename)
  File.readlines(filename)[0].split(',').map(&:to_i)
end

class Fish
  def initialize(days = 8)
    @days = days
  end

  def should_spawn?
    should_spawn = @days == 0
    @days = @days == 0 ? 6 : @days - 1
    should_spawn
  end
end

class School
  def initialize(days_array)
    @old_fish = days_array.map { |days_left| Fish.new(days_left) }
  end

  def increment_day
    new_fish = []
    @old_fish.each { |fish| new_fish.append(Fish.new) if fish.should_spawn? }
    @old_fish += new_fish
  end

  def increment_days(days)
    days.times { increment_day }
    self
  end

  def count
    @old_fish.count
  end
end

# days_array = read_input('./input')
days_array = read_input('./try_input')

p School.new(days_array).increment_days(80).count