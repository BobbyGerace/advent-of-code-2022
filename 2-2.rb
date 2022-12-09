class StrategyCalculator
  attr_reader :total_score

  def initialize
    @total_score = 0
  end

  def get_shape(theirs, strategy)
    combined = strategy + theirs
    case combined 
    when 'XB', 'YA', 'ZC' then 'A'
    when 'XC', 'YB', 'ZA' then 'B'
    when 'XA', 'YC', 'ZB' then 'C'
    end
  end

  def score_shape(shape)
    case shape
    when 'A' then 1
    when 'B' then 2
    when 'C' then 3
    end
  end

  def score_outcome(theirs, mine)
    combined = mine + theirs
    case combined 
    when 'AB', 'BC', 'CA' then 0
    when 'AA', 'BB', 'CC' then 3
    when 'AC', 'BA', 'CB' then 6
    end
  end

  def ingest_round(theirs, strategy) 
    mine = get_shape(theirs, strategy)
    @total_score += score_shape(mine) + score_outcome(theirs, mine)
  end
end

calculator = StrategyCalculator.new
File.open('input-2.txt').each do |line|
  calculator.ingest_round(*(line.split ' '))
end

puts calculator.total_score
