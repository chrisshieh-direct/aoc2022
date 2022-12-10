class Screen
  attr_accessor :cycle, :reg, :signals, :screen, :screen_line_number

  SIGNAL_CHECKS = [20, 60, 100, 140, 180, 220].freeze
  SCREEN_LINES = [40, 80, 120, 160, 200].freeze

  def initialize
    @cycle = 0
    @reg = 1
    @signals = []
    @screen = []
    reset_screen
    @screen_line_number = 0
  end

  def check
    self.cycle += 1
    if SIGNAL_CHECKS.include?(cycle)
      signals << cycle * reg
    end
  end

  def eval(x)
      check
    if x[0] == 'a'
      check
      amt = x[5..].to_i
      self.reg += amt
    end
  end

  def result
    puts signals.reduce(:+)
  end

  def reset_screen
    6.times do |x|
      temp_array = Array.new
      40.times { temp_array << ' ' }
      screen << temp_array
    end
  end

  def print_screen
    6.times { |x| p screen[x].join }
  end

  def rasterize(x)
    flip_pixel
    if x[0] == 'a'
      flip_pixel
      amt = x[5..].to_i
      self.reg += amt
    end
  end

  def flip_pixel
    self.cycle += 1
    a = reg - 1
    b = reg
    c = reg + 1
    if [a, b, c].include?(cycle - 1)
      screen[screen_line_number][cycle - 1] = "\u2588"
    end

    if SCREEN_LINES.include?(cycle)
      self.screen_line_number += 1
      self.cycle -= 40
    end
  end
end

# main program begins here
instructions = []

File.readlines('aocdata.txt').each do |x|
  instructions << x.chomp
end

part1 = Screen.new
instructions.each do |line|
  part1.eval(line)
end

system "clear"
puts "Part 1"
part1.result

puts '---'
part2 = Screen.new
instructions.each do |line|
  part2.rasterize(line)
end

puts "Part 2"
part2.print_screen
