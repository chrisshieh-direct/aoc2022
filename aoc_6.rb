require 'Benchmark'

arr = ['a', 'b', 'c', 'd', 'e', 'f,' 'g,' 'h', 'f,' 'g,' 'h', 'f,' 'g,' 'h']

code1 = proc do
  1000000.times { arr.uniq == arr }
end

result1 = Benchmark.measure(&code1)
puts result1

code2 = proc do
  1000000.times { arr.uniq.size == 14 }
end

result2 = Benchmark.measure(&code2)
puts result2

code3 = proc do
  1000000.times { arr.uniq.size == arr.size }
end

result3 = Benchmark.measure(&code2)
puts result3
