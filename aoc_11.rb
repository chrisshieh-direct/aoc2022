class Monkeys
  attr_accessor :monkey_set

  def initialize
    @monkey_set = {}
  end

  def get_monkeys
    # read from data file
    # search for "Monkey X" --> name of Monkey
    # search for "items: X" --> starting items for :holding
    # search for "old X" --> determine operator
    # search for str[-3, 3] == "old" --> operator is **2
    # search for "*/+ X" --> number
    # search for "divisible by X" --> divisor
    # search for "If true: throw to monkey X" --> true throw target
    # search for "If false: throw to monkey X" --> false throw target
    add_monkey(name, operator, number, divisor, true_target, false_target, *holding)
  end

  def add_monkey(name, operator, number, divisor, true_target, false_target, *holding)
    monkey_set[name] = Monkey.new(operator, number, divisor, true_target, false_target, *holding)
  end

  def display_monkey_set
    monkey_set.each do |k, v|
      puts "Monkey #{k}:"
      puts v
    end
  end

  def display_holdings
    monkey_set.each do |k, v|
      p v.holding
    end
  end

  def get_inspections_array
    inspection_array = []
    monkey_set.each do |k, v|
      inspection_array << v.inspections
    end
    inspection_array
  end

  def round(worried: false)
    monkey_set.each do |k, v|
      v.round(monkey_set, worried: worried)
    end
  end
end

class Monkey
  @@LCM = 1

  attr_accessor :holding, :operator, :number, :divisor, :true_target, :false_target, :inspections

  def initialize(operator, number, divisor, true_target, false_target, *holding)
    @operator = operator
    @number = number
    @divisor = divisor
    @true_target = true_target
    @false_target = false_target
    @holding = holding
    @inspections = 0
    @@LCM *= divisor
  end

  def operate(item)
    case operator
    when '*'
      item * number
    when '+'
      item + number
    when '**'
      item ** number
    end
  end

  def self.LCM
    @@LCM
  end

  def to_s
    response = <<-HEREDOC
    Starting items: #{holding.join(', ')}
    Operation: new = old #{operator} #{number}
    Test: divisible by #{divisor}
      If true: throw to monkey #{true_target}
      If false: throw to monkey #{false_target}

    HEREDOC
    response
  end

  def round(monkey_set, worried: false)
    holding.each do |item|
      self.inspections += 1
      item = operate(item)
      item = item / 3 if worried
      item = item % @@LCM
      if item % divisor == 0
        monkey_set[true_target].holding << item
      else
        monkey_set[false_target].holding << item
      end
    end
    self.holding = []
  end
end

puzzle = Monkeys.new

# SAMPLE DATA
# puzzle.add_monkey(0, '*', 19, 23, 2, 3, 79, 98)
# puzzle.add_monkey(1, '+', 6, 19, 2, 0, 54, 65, 75, 74)
# puzzle.add_monkey(2, '**', 2, 13, 1, 3, 79, 60, 97)
# puzzle.add_monkey(3, '+', 3, 17, 0, 1, 74)

puzzle.add_monkey(0, '*', 11, 13, 4, 7, 63, 84, 80, 83, 84, 53, 88, 72)
puzzle.add_monkey(1, '+', 4, 11, 5, 3, 67, 56, 92, 88, 84)
puzzle.add_monkey(2, '**', 2, 2, 3, 1, 52)
puzzle.add_monkey(3, '+', 2, 5, 5, 6, 59, 53, 60, 92, 69, 72)
puzzle.add_monkey(4, '+', 3, 7, 7, 2, 61, 52, 55, 61)
puzzle.add_monkey(5, '+', 1, 3, 0, 6, 79, 53)
puzzle.add_monkey(6, '+', 5, 19, 4, 0, 59, 86, 67, 95, 92, 77, 91)
puzzle.add_monkey(7, '*', 19, 17, 2, 1, 58, 83, 89)

# puzzle.display_monkey_set

# # PART ONE
# 20.times { puzzle.round(worried: true) }
# puts "Part 1:"
# puts puzzle.get_inspections_array.max(2).reduce(:*)

# PART TWO
10000.times { puzzle.round(worried: false) }
puts "Part 2:"
puts puzzle.get_inspections_array
puts puzzle.get_inspections_array.max(2).reduce(:*)
