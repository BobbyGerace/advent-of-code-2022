count = 0

File.open('./input-4.txt').each do |line|
  left, right = line.split(',').map do |x| 
    x.split('-').map { |n| n.to_i }
  end

  r_inside_l = left[0] <= right[0] && left[1] >= right[0]
  l_inside_r = right[0] <= left[0] && right[1] >= left[0]

  count += 1 if r_inside_l || l_inside_r
end

puts count
