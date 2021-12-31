def read_input(filename)
  File.readlines(filename)[0].split(',').map(&:to_i)
end

class School
  def initialize(days_array)
    @fish = {}
    @new_fish = 0
    days_array.each { |days| @fish[days] = (@fish[days] || 0) + 1 }
  end

  def increment_day
    new_count = {8 => @new_fish}
    @new_fish = 0
        
    @fish.each { |days, count| new_count[days - 1] = count }
    @new_fish = new_count[0] if new_count[0]

    if new_count[-1]
      new_count[6] = (new_count[6] || 0) + new_count[-1]
      new_count.delete(-1)
    end
    @fish = new_count
  end

  def increment_days(days)
    days.times { increment_day }
    self
  end

  def count
    @fish.values.sum
  end
end

days_array = read_input('./input')
# days_array = read_input('./try_input')

p School.new(days_array).increment_days(256).count
