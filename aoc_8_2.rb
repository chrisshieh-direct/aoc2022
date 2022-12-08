arr = []

File.readlines('aocdata.txt').each do |line|
  arr << line.chomp.chars
end

def look_left(line, tree, lidx)
  count = 0
  loop do
    lidx -= 1
    break if lidx < 0
    if line[lidx] < tree
      count += 1
    else
      count += 1
      break
    end
  end
  count
end

def look_right(line, tree, lidx)
  count = 0
  loop do
    lidx += 1
    break if lidx == line.length
    if line[lidx] < tree
      count += 1
    else
      count += 1
      break
    end
  end
  count
end

def look_up(arr, idx, tree, lidx)
  count = 0
  loop do
    idx -= 1
    break if idx < 0
    if arr[idx][lidx] < tree
      count += 1
    else
      count += 1
      break
    end
  end
  count
end

def look_down(arr, idx, tree, lidx)
  count = 0
  loop do
    idx += 1
    break if idx == arr.length
    if arr[idx][lidx] < tree
      count += 1
    else
      count += 1
      break
    end
  end
  count
end

max_visible = 0

arr.each_with_index do |line, idx|
  line.each_with_index do |tree, lidx|
    a = look_left(line, tree, lidx)
    b = look_right(line, tree, lidx)
    c = look_up(arr, idx, tree, lidx)
    d = look_down(arr, idx, tree, lidx)
    visible = a * b * c * d
    max_visible = visible if visible > max_visible
  end
end

p max_visible
