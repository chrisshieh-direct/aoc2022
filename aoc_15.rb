class Zone
  attr_accessor :locs, :grid, :min_x, :max_x, :min_y, :max_y, :sensors, :undetected

  def initialize
    @grid = []
    @locs = []
    @min_x = 0
    @max_x = 0
    @min_y = 0
    @max_y = 0
    @sensors = []
    get_locs
    # make_grid
    orient_sensors
    @undetected = []
  end

  def get_locs
    @locs = File.readlines('aocdata.txt').map do |line|
      line.scan(/[-=]\d+/).map do |vals|
        if vals[0] == '='
          vals[1..].to_i
        else
          vals.to_i
        end
      end
    end
  end

  def make_grid
    get_min_maxes
  end

  def get_min_maxes
    locs.each_with_index do |data, idx|
      if idx == 0
        self.min_x = data[0]
        self.max_x = data[0]
        self.min_y = data[1]
        self.max_y = data[1]
      end
      self.min_x = data[0] if data[0] < min_x
      self.min_x = data[2] if data[2] < min_x
      self.max_x = data[0] if data[0] > max_x
      self.max_x = data[2] if data[2] > max_x
      self.min_y = data[1] if data[1] < min_y
      self.min_y = data[3] if data[3] < min_y
      self.max_y = data[1] if data[1] > max_y
      self.max_y = data[3] if data[3] > max_y
    end
  end

  def mins
    resp = <<~HEREDOC
      min_x = #{min_x}
      max_x = #{max_x}
      min_y = #{min_y}
      max_y = #{max_y}
    HEREDOC
    resp
  end

  def orient_sensors
    locs.each do |data|
      sensors << Sensor.new(data[0], data[1], data[2], data[3])
    end
  end

  def check_row_covered(row)
    row_covered = []
    sensors.each do |sensor|
      row_covered << sensor.find_coverage(row) if sensor.find_coverage(row) != nil
    end
    row_covered.sort!
    min_max = [[row_covered.first[0], row], [row_covered.first[1], row]]
    row_covered.each do |spread|
      min_max[0][0] = spread[0] if spread[0] < min_max[0][0]
      min_max[1][0] = spread[1] if spread[1] > min_max[1][0]
    end
    (min_max[1][0] - min_max[0][0]).abs
  end

  def find_beacon(row)
    row_covered = []
    sensors.each do |sensor|
      row_covered << sensor.find_coverage(row) if sensor.find_coverage(row) != nil
    end
    row_covered.sort!
  end

  def find_perimeters(max_coord)
    result = []
    0.upto(max_coord) do |banana|
      check = find_beacon(banana)
      combine_ranges(check, banana)
    end
    result
  end

  def combine_ranges(arr, banana)
    buffer = arr[0]
    result = []

    1.upto(arr.length - 1) do |apple|
      if (buffer[1] - arr[apple][0]) >= -1
        buffer = [[arr[apple][0], buffer[0]].min, [arr[apple][1], buffer[1]].max]
      else
        p self.undetected = [arr[apple][0] - 1, banana]
      end
    end
    buffer
  end
end

class Sensor
  attr_accessor :x, :y, :beacon_x, :beacon_y, :manhattan_distance, :cover_array

  def initialize(x, y, beacon_x, beacon_y)
    @x = x
    @y = y
    @beacon_x = beacon_x
    @beacon_y = beacon_y
    @manhattan_distance = calc_manhattan
    @cover_array = []
  end

  def calc_manhattan
    @manhattan_distance = (@x - @beacon_x).abs + (@y - @beacon_y).abs
  end

  def find_coverage(row)
    diff_y = (row - y).abs
    return nil if diff_y > manhattan_distance
    diff_x = manhattan_distance - diff_y
    left_bound = x - diff_x
    right_bound = x + diff_x
    [left_bound, right_bound]
  end
end

p before = Time.now
bob = Zone.new
bob.find_perimeters(4000000)
p Time.now - before
