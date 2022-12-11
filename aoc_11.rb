require 'prime'

class Monkeys
  attr_accessor :zero, :one, :two, :three, :zero_insp, :one_insp, :two_insp, :three_insp

  def initialize
    @zero = [79, 98]
    @one = [54, 65, 75, 74]
    @two = [79, 60, 97]
    @three = [74]
    @zero_insp = 0
    @one_insp = 0
    @two_insp = 0
    @three_insp = 0
  end

  def round
    zero_inspect(zero)
    one_inspect(one)
    two_inspect(two)
    three_inspect(three)
  end

  # def make_em_big
  #   @zero.map! { |x| BigDecimal(x) }
  #   @one.map! { |x| BigDecimal(x) }
  #   @two.map! { |x| BigDecimal(x) }
  #   @three.map! { |x| BigDecimal(x) }
  # end

  def custom_modulo(number)
  end

  def zero_inspect(arr)
    arr.each do |item|
      self.zero_insp += 1
      new = item * 19
      new = new % 96577
      if new % 23 == 0
        self.two << new
      else
        self.three << new
      end
    end
    self.zero = []
  end

  def one_inspect(arr)
    arr.each do |item|
      self.one_insp += 1
      new = item + 6
      new = new % 96577
      if new % 19 == 0
        self.two << new
      else
        self.zero << new
      end
    end
    self.one = []
  end

  def two_inspect(arr)
    arr.each do |item|
      self.two_insp += 1
      new = item * item
      new = new % 96577
      if new % 13 == 0
        self.one << new
      else
        self.three << new
      end
    end
    self.two = []
  end

  def three_inspect(arr)
    arr.each do |item|
      self.three_insp += 1
      new = item + 3
      new = new % 96577
      if new % 17 == 0
        self.zero << new
      else
        self.one << new
      end
    end
    self.three = []
  end

  def display
    # p zero, one, two, three
    p [zero_insp, one_insp, two_insp, three_insp]
    p [zero_insp, one_insp, two_insp, three_insp].max(2).reduce(:*)
  end
end

bob = Monkeys.new

10000.times { bob.round }

bob.display
