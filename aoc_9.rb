class Rope
  attr_accessor :h, :one, :two, :three, :four, :five, :six, :seven, :eight, :nine, :ropey
  def initialize
    @h = [0, 0]
    @one = [0, 0]
    @two = [0, 0]
    @three = [0, 0]
    @four = [0, 0]
    @five = [0, 0]
    @six = [0, 0]
    @seven = [0, 0]
    @eight = [0, 0]
    @nine = [0, 0]

    @ropey = [@h, @one, @two, @three, @four, @five, @six, @seven, @eight, @nine]
    @tail_locs = Hash.new(0)
    @tail_locs[[0, 0]] = 1
  end

  def right
    @h[0] += 1
    @ropey.each_cons(2) do |arr1, arr2|
      pos_check(arr1, arr2)
    end
  end

  def left
    @h[0] -= 1
    @ropey.each_cons(2) do |arr1, arr2|
      pos_check(arr1, arr2)
    end
  end

  def up
    @h[1] += 1
    @ropey.each_cons(2) do |arr1, arr2|
      pos_check(arr1, arr2)
    end
  end

  def down
    @h[1] -= 1
    @ropey.each_cons(2) do |arr1, arr2|
      pos_check(arr1, arr2)
    end
  end

  def pos_check(arr1, arr2)
    if arr1[0] - 2 == arr2[0] && arr1[1] == arr2[1]
      arr2[0] += 1
    elsif arr1[0] - 2 == arr2[0] && arr1[1] - 1 == arr2[1]
      arr2[0] += 1
      arr2[1] += 1
    elsif arr1[0] - 2 == arr2[0] && arr1[1] + 1 == arr2[1]
      arr2[0] += 1
      arr2[1] -= 1
    elsif arr1[0] + 2 == arr2[0] && arr1[1] == arr2[1]
      arr2[0] -= 1
    elsif arr1[0] + 2 == arr2[0] && arr1[1] - 1 == arr2[1]
      arr2[0] -= 1
      arr2[1] += 1
    elsif arr1[0] + 2 == arr2[0] && arr1[1] + 1 == arr2[1]
      arr2[0] -= 1
      arr2[1] -= 1
    elsif arr1[1] + 2 == arr2[1] && arr1[0] == arr2[0]
      arr2[1] -= 1
    elsif arr1[1] + 2 == arr2[1] && arr1[0] - 1 == arr2[0]
      arr2[1] -= 1
      arr2[0] += 1
    elsif arr1[1] + 2 == arr2[1] && arr1[0] + 1 == arr2[0]
      arr2[1] -= 1
      arr2[0] -= 1
    elsif arr1[1] - 2 == arr2[1] && arr1[0] == arr2[0]
      arr2[1] += 1
    elsif arr1[1] - 2 == arr2[1] && arr1[0] - 1 == arr2[0]
      arr2[1] += 1
      arr2[0] += 1
    elsif arr1[1] - 2 == arr2[1] && arr1[0] + 1 == arr2[0]
      arr2[1] += 1
      arr2[0] -= 1
    elsif arr1[0] - 2 == arr2[0] && arr1[1] - 2 == arr2[1]
      arr2[1] += 1
      arr2[0] += 1
    elsif arr1[0] - 2 == arr2[0] && arr1[1] + 2 == arr2[1]
      arr2[0] += 1
      arr2[1] -= 1
    elsif arr1[0] + 2 == arr2[0] && arr1[1] - 2 == arr2[1]
      arr2[0] -= 1
      arr2[1] += 1
    elsif arr1[0] + 2 == arr2[0] && arr1[1] + 2 == arr2[1]
      arr2[0] -= 1
      arr2[1] -= 1
    end
    @tail_locs[@nine.dup] += 1
  end

  def show
    @tail_locs
  end
end

bob = Rope.new

arr = File.readlines('aocdata.txt').each_with_object([]) do |line, array|
  temp = []
  temp << line[0]
  temp << line[2..].chomp.to_i
  array << temp
end

arr.each do |subarr|
  instr = subarr[0]
  number = subarr[1]

  case instr
  when 'R'
    number.times { bob.right }
  when 'L'
    number.times { bob.left }
  when 'U'
    number.times { bob.up }
  when 'D'
    number.times { bob.down }
  end
end

puts bob.show.keys.length
