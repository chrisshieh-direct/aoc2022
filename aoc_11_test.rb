require 'bigdecimal'

class Monkeys
  attr_accessor :zero, :one, :two, :three, :four, :five, :six, :seven, :zero_insp, :one_insp, :two_insp, :three_insp, :four_insp, :five_insp, :six_insp, :seven_insp

  def initialize
    @zero = [63, 84, 80, 83, 84, 53, 88, 72]
    @one = [67, 56, 92, 88, 84]
    @two = [52]
    @three = [59, 53, 60, 92, 69, 72]
    @four = [61, 52, 55, 61]
    @five = [79, 53]
    @six = [59, 86, 67, 95, 92, 77, 91]
    @seven = [58, 83, 89]
    @zero_insp = 0
    @one_insp = 0
    @two_insp = 0
    @three_insp = 0
    @four_insp = 0
    @five_insp = 0
    @six_insp = 0
    @seven_insp = 0
  end

  # def make_em_big
  #   @zero.map! { |x| BigDecimal(x) }
  #   @one.map! { |x| BigDecimal(x) }
  #   @two.map! { |x| BigDecimal(x) }
  #   @three.map! { |x| BigDecimal(x) }
  #   @four.map! { |x| BigDecimal(x) }
  #   @five.map! { |x| BigDecimal(x) }
  #   @six.map! { |x| BigDecimal(x) }
  #   @seven.map! { |x| BigDecimal(x) }
  # end

  def round
    zero_inspect(zero)
    one_inspect(one)
    two_inspect(two)
    three_inspect(three)
    four_inspect(four)
    five_inspect(five)
    six_inspect(six)
    seven_inspect(seven)
  end

  def zero_inspect(arr)
    arr.each do |item|
      self.zero_insp += 1
      new = item * 11
      new = new % 9699690
      if new % 13 == 0
        self.four << new
      else
        self.seven << new
      end
    end
    self.zero = []
  end

  def one_inspect(arr)
    arr.each do |item|
      self.one_insp += 1
      new = item + 4
      new = new % 9699690
      if new % 11 == 0
        self.five << new
      else
        self.three << new
      end
    end
    self.one = []
  end

  def two_inspect(arr)
    arr.each do |item|
      self.two_insp += 1
      new = item * item
      new = new % 9699690
      if new % 2 == 0
        self.three << new
      else
        self.one << new
      end
    end
    self.two = []
  end

  def three_inspect(arr)
    arr.each do |item|
      self.three_insp += 1
      new = item + 2
      new = new % 9699690
      if new % 5 == 0
        self.five << new
      else
        self.six << new
      end
    end
    self.three = []
  end

  def four_inspect(arr)
    arr.each do |item|
      self.four_insp += 1
      new = item + 3
      new = new % 9699690
      if new % 7 == 0
        self.seven << new
      else
        self.two << new
      end
    end
    self.four = []
  end

  def five_inspect(arr)
    arr.each do |item|
      self.five_insp += 1
      new = item + 1
      new = new % 9699690
      if new % 3 == 0
        self.zero << new
      else
        self.six << new
      end
    end
    self.five = []
  end

  def six_inspect(arr)
    arr.each do |item|
      self.six_insp += 1
      new = item + 5
      new = new % 9699690
      if new % 19 == 0
        self.four << new
      else
        self.zero << new
      end
    end
    self.six = []
  end

  def seven_inspect(arr)
    arr.each do |item|
      self.seven_insp += 1
      new = item * 19
      new = new % 9699690
      if new % 17 == 0
        self.two << new
      else
        self.one << new
      end
    end
    self.seven = []
  end

  def display
    p [zero_insp, one_insp, two_insp, three_insp, four_insp, five_insp, six_insp, seven_insp].max(2).reduce(:*)
  end
end

bob = Monkeys.new

10000.times { bob.round }

bob.display
