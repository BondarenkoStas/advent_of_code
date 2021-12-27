content = File.readlines('./input').map(&:to_s)
# content = File.readlines('./try_input').map(&:to_s)

def calc_power_consumption content
    count_ones = Array.new(content[0].strip.length, 0)
    content.each do |line|
        numbers = line.strip.split('').map(&:to_i)
        count_ones = [count_ones, numbers].transpose.map {|x| x.reduce(:+)}
    end

    half = content.length / 2
    gamma = count_ones.map{ |x| x > half ? 1 : 0 }.join('')
    epsilon = count_ones.map{ |x| x < half ? 1 : 0}.join('')
    gamma.to_i(2) * epsilon.to_i(2)
end

puts calc_power_consumption content
