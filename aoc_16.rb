class Cave
  attr_accessor :valves, :key_rooms

  def initialize(input_hash)
    @valves = create_valves(input_hash)
    @key_rooms = find_key_rooms
  end

  def create_valves(input_hash)
    result = {}
    input_hash.map do |subhash|
      Valve.new(subhash[:valve_name], subhash[:flow], subhash[:paths])
    end.each do |valve|
      result[valve.name] = valve
    end
    result
  end

  def show_valves
    valves.each do |key, value|
      puts value
    end
  end

  def show_key_rooms
    key_rooms.each do |key, value|
      puts value
    end
  end

  def find_key_rooms
    rooms = valves.select do |key, value|
      key == "AA" || value.flow > 0
    end
  end

  def find_all_paths
    all_rooms = key_rooms.keys
    start_room = all_rooms.shift
    other_rooms = all_rooms.permutation.to_a
    start_room, other_rooms

  end
end

class Valve
  attr_accessor :name, :flow, :paths, :status

  def initialize(name, flow, paths)
    @name = name
    @flow = flow
    @paths = paths
    @status = 'closed'
  end

  def to_s
    "#{name}: #{flow} flow, exits to #{paths}, currently #{status}"
  end
end

data = File.readlines('aocdata_sample.txt').map do |line|
  rate = line.scan(/=\d+/).first.chars
  rate.shift
  rate = rate.join.to_i
  exits = line.scan(/[A-Z][A-Z]/)
  { valve_name: exits[0], flow: rate, paths: exits[1..] }
end

bob = Cave.new(data)
bob.show_valves
bob.show_key_rooms

p bob.find_all_paths
