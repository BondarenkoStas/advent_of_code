# content = File.readlines('./test_input').map(&:to_i)
content = File.readlines('./input').map(&:to_i)

def count_increses content
    count = 0
    prev = content[0]
    for index in 1 ... content.length
        if content[index] > prev
            count += 1
        end
        prev = content[index]
    end
    count
end

def count_windows content
    l, r = 0, 3
    current_sum = content[l...r].sum
    windows = [current_sum]
    while r < content.length
        windows.append(windows[-1] - content[l] + content[r])
        r += 1
        l += 1
    end
    count_increses(windows)
end

puts count_windows(content)
