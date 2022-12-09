require 'set'

class Vector
  attr_reader :x, :y
  def initialize(x, y)
    @x = x
    @y = y
  end

  def +(vec)
    Vector.new(@x + vec.x, @y + vec.y)
  end

  def to_s
    "(#{@x},#{@y})"
  end
end

class RopeTracker
  def initialize(knot_num)
    @knots = Array.new(knot_num).map { Vector.new(0, 0) }
    @tail_positions = Set.new
  end

  def move_head(direction, times)
    times.times do 
      case direction
      when 'R'
        @knots[0] += Vector.new(1, 0)
      when 'U'
        @knots[0] += Vector.new(0, 1)
      when 'L'
        @knots[0] += Vector.new(-1, 0)
      when 'D'
        @knots[0] += Vector.new(0, -1)
      end

      move_tail
    end
  end

  def move_tail
    (1...@knots.length).each do |i|
      head = @knots[i-1]
      tail = @knots[i]
      x_diff = head.x - tail.x
      y_diff = head.y - tail.y

      next unless x_diff.abs > 1 || y_diff.abs > 1

      x_dir = x_diff == 0 ? 0 : x_diff / x_diff.abs
      y_dir = y_diff == 0 ? 0 : y_diff / y_diff.abs

      @knots[i] += Vector.new(x_dir, y_dir)
    end

    @tail_positions.add(@knots.last.to_s)
  end

  def count_tail_positions
    @tail_positions.size
  end
end

tracker = RopeTracker.new(10)
File.open('input-9.txt').each do |line|
  dir, times = line.strip.split(' ')
  tracker.move_head(dir, times.to_i)
end

puts tracker.count_tail_positions
