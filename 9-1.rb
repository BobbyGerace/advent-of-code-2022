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
  def initialize
    @head = Vector.new(0, 0)
    @tail = Vector.new(0, 0)
    @tail_positions = Set.new
  end

  def move_head(direction, times)
    times.times do 
      case direction
      when 'R'
        @head += Vector.new(1, 0)
      when 'U'
        @head += Vector.new(0, 1)
      when 'L'
        @head += Vector.new(-1, 0)
      when 'D'
        @head += Vector.new(0, -1)
      end

      move_tail
    end
  end

  def move_tail
    x_diff = @head.x - @tail.x
    y_diff = @head.y - @tail.y

    return unless x_diff.abs > 1 || y_diff.abs > 1

    x_dir = x_diff == 0 ? 0 : x_diff / x_diff.abs
    y_dir = y_diff == 0 ? 0 : y_diff / y_diff.abs

    @tail += Vector.new(x_dir, y_dir)

    @tail_positions.add(@tail.to_s)
  end

  def count_tail_positions
    @tail_positions.size
  end
end

tracker = RopeTracker.new
File.open('input-9.txt').each do |line|
  dir, times = line.strip.split(' ')
  tracker.move_head(dir, times.to_i)
end

puts tracker.count_tail_positions
