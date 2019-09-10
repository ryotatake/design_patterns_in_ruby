# Strategyパターンのコード
class TestResult
  attr_reader :name, :japanese, :math, :english
  attr_accessor :comparator

  def initialize(name, japanese, math, english, comparator)
    @name       = name
    @japanese   = japanese
    @math       = math
    @english    = english
    @comparator = comparator
  end

  def compare(target)
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


result1 = TestResult.new("佐藤", 50, 50, 50, JapaneseScoreComparator.new)
result2 = TestResult.new("ジョン", 10, 70, 100, JapaneseScoreComparator.new)

result1.comparator = TotalScoreComparator.new
result1.compare(result2)

#==============================
# 特異クラス
#==============================

result3 = {:name => "ポチ", :japanese => 100, :math => 100, :english => 100}

class << result3
  def name
    self[:name]
  end

  def japanese
    self[:japanese]
  end

  def math
    self[:math]
  end

  def english
    self[:english]
  end
end

result1.compare(result3)

#==============================
# Adapter
#==============================

class HashTestResultAdapter
  attr_reader :name, :japanese, :math, :english

  def initialize(hash)
    @name     = hash[:name]
    @japanese = hash[:japanese]
    @math     = hash[:math]
    @english  = hash[:english]
  end
end

result4 = {:name => "ポチ", :japanese => 100, :math => 100, :english => 100}
adapter = HashTestResultAdapter.new(result4)

result1.compare(adapter)
