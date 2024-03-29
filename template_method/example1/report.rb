class Report
  def initialize
    @title = '月次報告'
    @text = [ '順調', '最高の調子' ]
  end

  # テンプレートメソッド
  def output_report
    output_start
    output_head
    output_body_start
    output_body
    output_body_end
    output_end
  end

  def output_body
    @text.each do |line|
      output_line(line)
    end
  end

  # フックメソッド: 実装は持っているので、具象クラスでオーバーライドしてもしなくても良い。
  def output_start
  end

  def output_head
    output_line(@title)
  end

  def output_body_start
  end

  # 抽象メソッド: 実装を持っていないので、具象クラスでオーバーライドする必要がある。
  def output_line(line)
    raise 'Called abstract method: output_line'
  end

  def output_body_end
  end

  def output_end
  end
end
