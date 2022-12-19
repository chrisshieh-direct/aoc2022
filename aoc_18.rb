require 'set'

MINIMUM = 0
MAXIMUM = 19

def find_mins(arr)
  x = 20
  y = 20
  z = 20

  arr.each do |subarr|
    x = subarr[0] if subarr[0] < x
    y = subarr[1] if subarr[1] < y
    z = subarr[2] if subarr[2] < z
  end

  p x, y, z
end

def find_maxes(arr)
  x = 0
  y = 0
  z = 0

  arr.each do |subarr|
    x = subarr[0] if subarr[0] > x
    y = subarr[1] if subarr[1] > y
    z = subarr[2] if subarr[2] > z
  end

  p x, y, z
end

def find_empty_cubes(cubes)
  return_array = []

  MINIMUM.upto(MAXIMUM) do |x|
    MINIMUM.upto(MAXIMUM) do |y|
      MINIMUM.upto(MAXIMUM) do |z|
        if filled?([x, y, z], cubes)
          next
        else
          return_array << [x, y, z]
        end
      end
    end
  end
  return_array
end

def find_faces(cubes)
  total_sides = 0
  cubes.each do |cube|
    sides = 6
    sides -= 1 if cubes.include?([(cube[0] - 1), cube[1], cube[2]])
    sides -= 1 if cubes.include?([(cube[0] + 1), cube[1], cube[2]])
    sides -= 1 if cubes.include?([cube[0], (cube[1] - 1), cube[2]])
    sides -= 1 if cubes.include?([cube[0], (cube[1] + 1), cube[2]])
    sides -= 1 if cubes.include?([cube[0], cube[1], (cube[2] - 1)])
    sides -= 1 if cubes.include?([cube[0], cube[1], (cube[2] + 1)])
    total_sides += sides
  end
  total_sides
end

def find_internal_cubes(empty_cubes, flood)
  internal_cubes = []
  empty_cubes.select do |cube|
    internal_cubes << cube unless flood.include?(cube)
  end
  internal_cubes
end


def flood_fill(cubes)
  queue = [[1, 1, 1]]
  empty_locs = Set.new

  until queue.empty?
    check = queue.shift
    if !filled?(check, cubes) && !empty_locs.include?(check)
      empty_locs << check

    [[0, 0, 1], [0, 0, -1], [0, 1, 0], [0, -1, 0], [1, 0, 0], [-1, 0, 0]].each do |dx, dy, dz|
      x_neigh, y_neigh, z_neigh = check[0] + dx, check[1] + dy, check[2] + dz
        if (MINIMUM..MAXIMUM).include?(x_neigh) && (MINIMUM..MAXIMUM).include?(y_neigh) && (MINIMUM..MAXIMUM).include?(z_neigh)
          if !filled?([x_neigh, y_neigh, z_neigh], cubes)
            queue << [x_neigh, y_neigh, z_neigh]
          end
        end
      end
    end
  end
  empty_locs
end

def filled?(arr, cubes)
  cubes.include?(arr)
end

cubes = File.readlines('aocdata.txt').map do |line|
  strs = line.chomp.split(',')
  strs.each.map {|str| str.to_i }
end

puts "flood"
flood = flood_fill(cubes)
p flood.length

puts "all empty"
empty_cubes = find_empty_cubes(cubes)
p empty_cubes.length

puts "internal cubes"
internal_cubes = find_internal_cubes(empty_cubes, flood)
p internal_cubes.length

puts "all exposed faces of lava"
p all_faces = find_faces(cubes)

puts "exposed of faces of 'air cubes' internally"
p internal_faces = find_faces(internal_cubes)

puts "exposed faces that are not trapped"
p all_faces - internal_faces
