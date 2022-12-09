class TopElfManager
  def initialize(n)
    @top_n_elves = []
    @n = n
  end

  def ingest(ins_elf, idx = 0)
    this_elf = @top_n_elves[idx]

    return if idx >= @n

    if @top_n_elves.size <= @n && this_elf.nil?
      @top_n_elves << ins_elf 
    elsif ins_elf > this_elf
      @top_n_elves[idx] = ins_elf
      ingest(this_elf, idx + 1)
    else
      ingest(ins_elf, idx + 1)
    end
  end

  def total_calories
    @top_n_elves.sum
  end
end

current_elf = 0

elf_manager = TopElfManager.new 3
File.open('input-1.txt').each do |line|
  if line =~ /\S/
    current_elf += line.to_i
  else
    elf_manager.ingest current_elf
    current_elf = 0
  end
end

puts elf_manager.total_calories
