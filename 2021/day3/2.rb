content = File.readlines('./input').map(&:to_s)
# content = File.readlines('./try_input').map(&:to_s)

def count(content_binary, most_common_criteria, bit_position)
    return content_binary[0].join('').to_i(2) if content_binary.length == 1

    half = content_binary.length / 2.0
    count_ones = content_binary.map{ |line| line[bit_position] }.sum
    most_common = count_ones >= half ? 1 : 0
    criteria = most_common_criteria ? most_common : 1 - most_common
    filtered_list = content_binary.select{ |line| line[bit_position] == criteria }

    count(filtered_list, most_common_criteria, bit_position + 1)
end

def get_life_support_rating(content)
    content_binary = content.map { |x| x.strip.split('').map{ |x| x.to_i(2) } }
    count(content_binary, true, 0) * count(content_binary, false, 0)
end

puts get_life_support_rating(content)
