content = File.readlines('./input').map(&:to_s)

def calc_position content
    x = y = aim = 0
    content.each do |line|
        direction, change = line.split(' ')
        change = change.to_i
        case direction
            when 'forward'
                x += change
                y += change * aim
            when 'down'
                aim += change
            when 'up'
                aim -= change
        end
    end
    return x, y
end

x, y = calc_position content

puts x * y
