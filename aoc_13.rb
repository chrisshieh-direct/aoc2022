def s_to_a(string)
  eval(string)
end

def compare(left, right)
  if (left.is_a? Integer) && (right.is_a? Integer)
    if left < right
      return 1
    elsif left > right
      return -1
    else
      return 0
    end
  end

  left = [left] if left.class != Array
  right = [right] if right.class != Array

  0.upto(left.length - 1) do |x|
    return -1 if right[x].nil?
    c = compare(left[x], right[x])
    if c == -1
      return -1
    elsif c == 1
      return 1
    end
  end

  return 1 if left.length < right.length
end

data = []

data_array = File.readlines('aocdata.txt')

counter = 0

loop do
  a = s_to_a(data_array[counter])
  b = s_to_a(data_array[counter + 1])
  data << [a, b]
  counter += 3
  break if counter >= data_array.length
end

right_order_packets = []

data.each_with_index do |pair, idx|
  if compare(pair[0], pair[1]) == 1
    right_order_packets << idx + 1
  end
end

puts "Part 1:"
p right_order_packets.reduce(:+)

data2 = []

data.each do |pair|
  data2 << pair[0]
  data2 << pair[1]
end

data2 << [[2]]
data2 << [[6]]

data2 = data2.sort {|a, b| compare(a, b) }.reverse

puts "Part 2:"
p (data2.find_index([[2]]) + 1) * (data2.find_index([[6]]) + 1)
