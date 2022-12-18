class Cave
  attr_accessor :min_width, :max_width, :max_depth, :cave_grid, :paths, :paths_adjusted, :width, :sand_units

  def initialize(paths)
    @min_width = 0
    @max_width = 0
    @max_depth = 0
    @cave_grid = []
    @paths = paths
    @paths_adjusted = nil
    @sand_units = 0
    check_max_depth
    check_max_width
    check_min_width
    generate_adjusted_paths
    @width = @max_width - @min_width + 1
    make_grid
    add_paths
  end

  def check_max_depth
    paths.each do |path|
      path.each do |node|
        self.max_depth = node[1] if node[1] > max_depth
      end
    end
    self.max_depth += 2
  end

  def check_max_width
    paths.each do |path|
      path.each do |node|
        self.max_width = node[0] if node[0] > max_width
      end
    end
    self.max_width += 1000 # allow for gap on right side
  end

  def check_min_width
    self.min_width = paths[0][0][0]

    paths.each do |path|
      path.each do |node|
        self.min_width = node[0] if node[0] < min_width
      end
    end
    self.min_width = 0 # allow for gap on left side
  end

  def generate_adjusted_paths
    self.paths_adjusted = paths.map do |path|
                            path.map do |node|
                              [(node[0] - min_width), node[1]]
                            end
                          end
  end

  def make_grid
    (max_depth).times do |line|
      line = []
      width.times { line << "." }
      self.cave_grid << line
    end
    line = []
    width.times { line << "#" }
    self.cave_grid << line
  end

  def add_paths
    paths_adjusted.each do |path|
      path.each_cons(2) do |node1, node2|
        if node1[0] == node2[0]
          start = [node1[1], node2[1]].min
          finish = [node1[1], node2[1]].max
          (start).upto(finish) do |x|
            cave_grid[x][node1[0]] = '#'
          end
        elsif node1[1] == node2[1]
          start = [node1[0], node2[0]].min
          finish = [node1[0], node2[0]].max
          (start).upto(finish) do |x|
            cave_grid[node1[1]][x] = '#'
          end
        end
      end
    end
    cave_grid[0][500 - min_width] = '+'
  end


  def show_cave
    puts min_width
    cave_grid.each_with_index do |line, idx|
      # puts "#{idx} #{line.join}"
      puts "#{line.join}"
    end
  end

  def drop_sand
    y = 1
    x = 500 - min_width

    loop do
      if cave_grid[y][x] == '.'
        y += 1
        if y == max_depth + 1
          puts max_depth
          puts "endless reached at #{sand_units}"
          break
        end
      elsif cave_grid[y][x] !='.'
        if cave_grid[y][x - 1] == '.'
          x -= 1
          next
        elsif cave_grid[y][x + 1] == '.'
          x += 1
          next
        else
          cave_grid[y-1][x] = 'O'
          self.sand_units += 1
          if y - 1 == 0 && x == 500 - min_width
            puts "Done, #{sand_units}"
            return
          end
          p sand_units
          break
        end
      end
    end
  end
end

paths = []

File.readlines('aocdata.txt').each do |line|
  paths << line.chomp.split(' -> ').map do |node|
    node.split(',').map { |x| x.to_i }
  end
end


bob = Cave.new(paths)

25000.times { bob.drop_sand }
