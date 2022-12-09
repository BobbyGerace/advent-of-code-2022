count = 0

File.open('./input-4.txt').each do |line|
  left, right = line.split(',').map do |x| 
    x.split('-').map { |n| n.to_i }
  end

  l_contains_r = left[0] <= right[0] && left[1] >= right[1]
  r_contains_l = right[0] <= left[0] && right[1] >= left[1]

  count += 1 if l_contains_r || r_contains_l
end

puts count
