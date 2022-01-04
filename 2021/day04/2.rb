content = File.readlines('./input').map(&:to_s)
# content = File.readlines('./try_input').map(&:to_s)

class Board
    def initialize(lines)
        @bingo_rows = Array.new(5, 0)
        @bingo_cols = Array.new(5, 0)
        @position = {}
        lines.each_with_index do |line, i|
            line.strip.split(' ').each_with_index do |number, j|
                if @position.key?(number)
                    @position[number].append([i,j])
                else
                    @position[number] = [[i, j]]
                end
            end
        end
    end

    def mark(number)
        is_solved = false
        if @position.key?(number)
            @position[number].each do |i, j|
                @bingo_rows[i] += 1
                @bingo_cols[j] += 1
                is_solved = true if @bingo_rows[i] == 5 || @bingo_cols == 5
            end
            @position.delete(number)
        end
        is_solved
    end

    def solved?
        @bingo_rows.any?(5) || @bingo_cols.any?(5)
    end

    def sum_unmarked
        @position.reduce(0){ |sum, (number, pos) | sum += number.to_i * pos.length}
    end
end

def last_bingo(lines)
    numbers = lines[0].strip.split(',')
    boards = (2..lines.length).step(6).reduce([]){|boards, i| boards.append(Board.new(lines[i, 5]))}
    numbers.each do |number|
        boards.each { |board| board.mark(number) }
        return number.to_i * boards[0].sum_unmarked if boards.length == 1 && boards[0].solved?
        
        boards.reject!(&:solved?)
    end
end

p last_bingo(content)
