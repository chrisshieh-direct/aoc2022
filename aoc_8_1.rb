arr = []

File.readlines('aocdata.txt').each do |line|
  arr << line.chomp.chars
end

def check_left?(line, tree, idx)
  line[0..idx].all? { |x| x < tree }
end

def check_right?(line, tree, idx)
  line[idx..].all? { |x| x < tree }
end

def check_up?(arr, idx, tree, lidx)
  0.upto(idx - 1) do |x|
    if arr[x][lidx] >= tree
      return false
    end
  end
  true
end

def check_down?(arr, idx, tree, lidx)
  (idx + 1).upto(arr.length - 1) do |x|
    if arr[x][lidx] >= tree
      return false
    end
  end
  true
end

edges = arr[0].length * 2 + arr.length * 2 - 4
visible = edges

arr.each_with_index do |line, idx|
  next if idx == 0
  next if idx == arr.length - 1
  line.each_with_index do |tree, lidx|
    next if lidx == 0
    next if lidx == line.length - 1
    if check_left?(line, tree, lidx - 1)
      visible += 1
      next
    elsif check_right?(line, tree, lidx + 1)
      visible += 1
      next
    elsif check_up?(arr, idx, tree, lidx)
      visible += 1
      next
    elsif check_down?(arr, idx, tree, lidx)
      visible += 1
    end
  end
end

p visible
