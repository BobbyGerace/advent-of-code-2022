queue = []
puts (File.read('./input-6.txt').split('').find_index do |char|
  queue.push char
  queue.shift if queue.size > 14
  queue.uniq.size == 14
end + 1)
