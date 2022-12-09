current_elf = 0
max_calories = 0

File.open('input-1.txt').each do |line|
  if line =~ /\S/
    current_elf += line.to_i
  else
    max_calories = current_elf if current_elf > max_calories
    current_elf = 0
  end
end

puts max_calories
