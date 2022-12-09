class Forest
  attr_reader :scenic_map
  def initialize
    @trees = []
  end

  def read_line(line)
    @trees << line.strip.split('').map(&:to_i)
    @scenic_map = []
  end

  def calculate_scenic_scores
    width = @trees.length
    height = @trees[0].length

    @scenic_map = Array.new(width).map { Array.new(height).fill(1) }

    @trees.each_with_index do |col, i|
      col.each_with_index do |tree, j|

        # left
        count = 0
        (0...i).reverse_each do |k|
          count += 1
          break if (@trees[k][j] >= tree)
        end
        @scenic_map[i][j] *= count

        # right
        count = 0
        ((i+1)...width).each do |k|
          count += 1
          break if (@trees[k][j] >= tree)
        end
        @scenic_map[i][j] *= count

        # top
        count = 0
        (0...j).reverse_each do |k|
          count += 1
          break if (@trees[i][k] >= tree)
        end
        @scenic_map[i][j] *= count

        # right
        count = 0
        ((j+1)...height).each do |k|
          count += 1
          break if (@trees[i][k] >= tree)
        end
        @scenic_map[i][j] *= count
      end
    end
  end
end

forest = Forest.new
File.open('input-8.txt').each { |line| forest.read_line(line) }
forest.calculate_scenic_scores

max = forest.scenic_map.map { |col| col.max }.max
puts max
