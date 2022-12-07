instructions = []
File.readlines('aocdata.txt').each do |line|
  if line[0] =~ /[0-9]/
    instructions << line.split.first.to_i
  elsif line.start_with?('$ c')
    instructions << line.split[1,2]
  end
end

totals = Hash.new(0)
path = []

instructions.each do |command|
  if command.is_a? Array
    if command[1] == '..'
      path.pop
    else
      path << command[1]
    end
  else
    path.length.times do |x|
      totals[path[0, x + 1].join('/')] += command
    end
  end
end

part1 = totals.select { |k, v| v < 100_000}.values.reduce(:+)
puts "Part 1 answer is #{part1}"

file_size_delete_needed = 30_000_000 - (70_000_000 - totals.values.max)
part2 = totals.values.select { |v| v >= file_size_delete_needed}.min
puts "Part 2 answer is #{part2}"
