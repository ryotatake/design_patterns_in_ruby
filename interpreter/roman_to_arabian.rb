# ref: https://github.com/AtsushiSakai/cpp_sandbox/blob/master/DesignPattern/Interpreter/Interpreter.cpp

class Context
  attr_accessor :input, :output

  def initialize(input)
    @input = input
    @output = 0
  end
end

class Expression
  def interpret(context)
    return if context.input.empty?

    if context.input.index(nine) == 0
      context.output += 9 * multiplier
      context.input = context.input.slice(2..-1)
    elsif context.input.index(four) == 0
      context.output += 4 * multiplier
      context.input = context.input.slice(2..-1)
    elsif context.input.index(five) == 0
      context.output += 5 * multiplier
      context.input = context.input.slice(1..-1)
    end

    while context.input.index(one) == 0
      context.output += 1 * multiplier
      context.input = context.input.slice(1..-1)
    end
  end

  def one
  end

  def four
  end

  def five
  end

  def nine
  end

  def multiplier
  end
end

class ThousandExpression < Expression
  def one
    "M"
  end

  def four
    " "
  end

  def five
    " "
  end

  def nine
    " "
  end

  def multiplier
    1000
  end
end

class HundredExpression < Expression
  def one
    "C"
  end

  def four
    "CD"
  end

  def five
    "D"
  end

  def nine
    "CM"
  end

  def multiplier
    100
  end
end

class TenExpression < Expression
  def one
    "X"
  end

  def four
    "XL"
  end

  def five
    "L"
  end

  def nine
    "XC"
  end

  def multiplier
    10
  end
end

class OneExpression < Expression
  def one
    "I"
  end

  def four
    "IV"
  end

  def five
    "V"
  end

  def nine
    "IX"
  end

  def multiplier
    1
  end
end

thousand = ThousandExpression.new
hundred = HundredExpression.new
ten = TenExpression.new
one = OneExpression.new

context = Context.new("MCMXVIII") # 1918

[thousand, hundred, ten, one].each do |expression|
  expression.interpret(context)
end

p context.output
