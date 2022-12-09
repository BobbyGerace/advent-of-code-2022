class PriorityCalculator
  attr_reader :total_priority

  @@priority_map = Hash.new
  (('a'..'z').to_a + ('A'..'Z').to_a).each_with_index do |letter, i|
    @@priority_map[letter] = i + 1
  end

  def initialize
    @total_priority = 0
  end

  def ingest(*args) 
    freq = Hash.new(0)
    badge = nil
    args.each do |line|
      line.strip.split('').uniq.each do |item|
        freq[item] += 1
        if freq[item] == 3
          badge = item
        end
      end
    end

    @total_priority += @@priority_map[badge]
  end
end

calculator = PriorityCalculator.new
File.open('input-3.txt').each_slice(3) do |lines|
  calculator.ingest(*lines)
end

puts calculator.total_priority
