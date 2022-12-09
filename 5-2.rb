class StackManager
  attr_reader :stacks

  def initialize
    @stacks = Array.new(9).map { [] }
  end

  def get_message
    @stacks.map { |s| s.last }.join('')
  end

  def read_stack_level(line)
    (0..8).each do |n|
      char = line[n * 4 + 1]
      stacks[n].unshift(char) if char =~ /\w/
    end
  end

  def read_instruction(line)
    num, from, to = line.scan(/\d+/).map {|x| x.to_i }

    crates = stacks[from - 1].slice!(-num, num)
    stacks[to - 1] += crates
  end

  def ingest(line)
    if line[0] == '['
      read_stack_level(line)
    elsif line[0] == 'm'
      read_instruction(line)
    end
  end
end

stack_manager = StackManager.new
File.open('./input-5.txt').each do |line|
  stack_manager.ingest(line)
end

puts stack_manager.get_message
