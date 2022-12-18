class Chamber
  attr_accessor :floor, :layers, :jets

  def initialize
    @floor = Layer.new('+-------+')
    @layers = [@floor]
    @jets = File.read('aocdata_sample.txt').chomp.chars
    @start = [4, 3]
  end

  def show_layers
    layers.reverse.each do |layer|
      puts "#{layer.content} #{layer.floor}"
    end
  end

  def add_empty_layer
    layers << Layer.new('|.......|')
  end

  def drop_horiz

  end
end

class Layer
  @@floor_counter = 0
  attr_accessor :content, :floor

  def initialize(content)
    @content = content
    @floor = @@floor_counter
    @@floor_counter += 1
  end
end




bob = Chamber.new
10.times { bob.add_empty_layer }

bob.show_layers
