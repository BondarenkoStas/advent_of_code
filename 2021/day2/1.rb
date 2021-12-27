content = File.readlines('./input').map(&:to_s)

def calc_position content
    x = y = 0
    content.each do |line|
        direction, change = line.split(' ')
        case direction
            when 'forward'
                x += change.to_i
            when 'down'
                y += change.to_i
            when 'up'
                y -= change.to_i
        end
    end
    return x, y
end

x, y = calc_position content

puts x * y
