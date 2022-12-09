queue = []
puts (File.read('./input-6.txt').split('').find_index do |char|
  queue.push char
  queue.shift if queue.size > 4
  queue.uniq.size == 4
end + 1)

# one-liner
p File.read('i').split('').reduce([]){|p,c|p.size<4||p[-4,4].uniq.size<4?p<<c:p}.size
