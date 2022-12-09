class PriorityCalculator
  attr_reader :total_priority

  @@priority_map = Hash.new
  (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index do |letter, i|
    @@priority_map[letter] = i + 1
  end

  def initialize
    @total_priority = 0
  end

  def ingest(line) 
    container_size = line.size / 2
    first = line[0...container_size].split('')
    second = line[container_size...].split('')

    item = first.find { |x| second.include?(x) }

    @total_priority += @@priority_map[item]
  end
end

calculator = PriorityCalculator.new
File.open('input-3.txt').each do |line|
  calculator.ingest(line)
end

puts calculator.total_priority
