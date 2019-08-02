# selfを渡すことで、Contextを変更したときの影響範囲が分からなくなる場合
# Strategyが何十個もあったら、Contextを少し変更したいだけでそのすべてを確認する必要がある。

class Human
  attr_reader :name, :age, :height, :weight
  attr_accessor :strategy

  def initialize(strategy)
    @name = "taro"
    @age = 20
    @height = 170
    @weight = 60
    @strategy = strategy
  end

  def output_info
    strategy.output_info(self)
  end
end

class NameStrategy
  def output_info(context)
    puts context.name
  end
end

class HeightStrategy
  def output_info(context)
    puts context.height
  end
end

class SomethingDifficultStrategy
  def output_info(context)
    something_difficult(context)
  end
end


#==========================================================================================


# 逆に必要なデータだけ渡していることで、他のStrategyが追加できない場合

class Human
  attr_reader :name, :age, :height, :weight
  attr_accessor :strategy

  def initialize(strategy)
    @name = "taro"
    @age = 20
    @height = 170
    @weight = 60
    @strategy = strategy
  end

  def output_info
    strategy.output_info(name)
  end
end

class NameStrategy
  def output_info(name)
    puts name
  end
end

# これは使えない
class HeightStrategy
  def output_info(height)
    puts height
  end
end
