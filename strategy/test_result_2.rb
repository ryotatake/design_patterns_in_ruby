class TestResult
  attr_reader :name, :japanese, :math, :english

  def initialize(name, japanese, math, english)
    @name = name
    @japanese = japanese
    @math = math
    @english = english
  end

  # strategyを一つのメソッドでしか使わないのであれば、引数に渡してあげても良い。Array#sortと似た感じ。
  def compare(target, comparator)
    comparator.compare(self, target)
  end
end

class JapaneseScoreComparator
  def compare(origin, target)
    case origin.japanese <=> target.japanese
    when 1
      puts "国語の結果は#{origin.name}さんの方が良いです。"
    when 0
      puts "国語の結果は#{origin.name}さんと#{target.name}さんで同じです。"
    when -1
      puts "国語の結果は#{target.name}さんの方が良いです。"
    end
  end
end

class MathScoreComparator
  def compare(origin, target)
    case origin.math <=> target.math
    when 1
      puts "数学の結果は#{origin.name}さんの方が良いです。"
    when 0
      puts "数学の結果は#{origin.name}さんと#{target.name}さんで同じです。"
    when -1
      puts "数学の結果は#{target.name}さんの方が良いです。"
    end
  end
end

class EnglishScoreComparator
  def compare(origin, target)
    case origin.english <=> target.english
    when 1
      puts "英語の結果は#{origin.name}さんの方が良いです。"
    when 0
      puts "英語の結果は#{origin.name}さんと#{target.name}さんで同じです。"
    when -1
      puts "英語の結果は#{target.name}さんの方が良いです。"
    end
  end
end

class TotalScoreComparator
  def compare(origin, target)
    origin_total = origin.japanese + origin.math + origin.english
    target_total = target.japanese + target.math + target.english
    case origin_total <=> target_total
    when 1
      puts "総合の結果は#{origin.name}さんの方が良いです。"
    when 0
      puts "総合の結果は#{origin.name}さんと#{target.name}さんで同じです。"
    when -1
      puts "総合の結果は#{target.name}さんの方が良いです。"
    end
  end
end


result1 = TestResult.new("佐藤", 50, 50, 50)
result2 = TestResult.new("ジョン", 10, 70, 100)

result1.compare(result2, JapaneseScoreComparator.new)
result1.compare(result2, MathScoreComparator.new)
result1.compare(result2, TotalScoreComparator.new)
