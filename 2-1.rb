class StrategyCalculator
  attr_reader :total_score

  def initialize
    @total_score = 0
  end

  def score_shape(shape)
    case shape
    when 'X' then 1
    when 'Y' then 2
    when 'Z' then 3
    end
  end

  def score_outcome(theirs, mine)
    combined = mine + theirs
    case combined 
    when 'XB', 'YC', 'ZA' then 0
    when 'XA', 'YB', 'ZC' then 3
    when 'XC', 'YA', 'ZB' then 6
    end
  end

  def ingest_round(theirs, mine) 
    @total_score += score_shape(mine) + score_outcome(theirs, mine)
  end
end

calculator = StrategyCalculator.new
File.open('input-2.txt').each do |line|
  calculator.ingest_round(*(line.split ' '))
end

puts calculator.total_score
