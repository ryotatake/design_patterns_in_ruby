class Food
  # テンプレートメソッド
  def prepare
    puts "******** 準備 ********"
    before_cook
    puts "******** 調理 ********"
    cook
    puts "******** 片付け ********"
    after_cook
  end

  # 抽象メソッド
  def before_cook
    raise NotImplementedError
  end

  def cook
    raise NotImplementedError
  end

  # フックメソッド
  def after_cook
    puts "使った器具を洗う"
  end
end

class ScrambledEgg < Food
  def before_cook
    puts "卵・バター・牛乳・塩を買う"
    puts "ボウル・フライパンを準備する"
  end

  def cook
    puts "ボウルに卵と牛乳、塩を入れ、よく混ぜる"
    puts "中火で熱したフライパンにバターを入れて溶かす"
    puts "弱火〜弱めの中火にし、卵液をフライパンに流し入れる"
    puts "卵の底が薄く固まったら混ぜる"
    puts "まとまりが出たら完成"
  end
end

class GingerGrilledPork < Food
  def before_cook
    puts "豚ロース・生姜チューブ・砂糖・酒・醤油・みりんを買う"
    puts "ボウル・フライパンを準備する"
  end

  def cook
    puts "ボウルに生姜チューブ・砂糖・酒・醤油・みりんを入れ、混ぜる"
    puts "フライパンで肉を軽く焼く"
    puts "混ぜておいたタレを入れ、タレがほとんどなくなれば完成"
  end
end
