class Forest
  attr_reader :visibility_map
  def initialize
    @trees = []
  end

  def read_line(line)
    @trees << line.strip.split('').map(&:to_i)
    puts @trees.last.join(',')
    @visibility_map = []
  end

  def mark_visible
    width = @trees.length
    height = @trees[0].length

    @visibility_map = Array.new(width).map { Array.new(height).fill(false) }

    # top to bottom
    (0...width).each do |i|
      max_height = -1
      (0...height).each do |j|
        if @trees[i][j] > max_height
          max_height = @trees[i][j]
          @visibility_map[i][j] = true
        end
      end
    end

    # bottom to top
    (0...width).each do |i|
      max_height = -1
      (0...height).reverse_each do |j|
        if @trees[i][j] > max_height
          max_height = @trees[i][j]
          @visibility_map[i][j] = true
        end
      end
    end

    # left to right
    (0...height).each do |j|
      max_height = -1
      (0...width).each do |i|
        if @trees[i][j] > max_height
          max_height = @trees[i][j]
          @visibility_map[i][j] = true
        end
      end
    end

    # right to left
    (0...height).each do |j|
      max_height = -1
      (0...width).reverse_each do |i|
        if @trees[i][j] > max_height
          max_height = @trees[i][j]
          @visibility_map[i][j] = true
        end
      end
    end
  end
end

forest = Forest.new
File.open('input-8.txt').each { |line| forest.read_line(line) }
forest.mark_visible

count = forest.visibility_map.sum { |col| col.count { |x| x } }
puts count
