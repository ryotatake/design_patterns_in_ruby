# Component Class
class Entry
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
  end

  def get_time_required
    0
  end

  def total_number_basic_tasks
    1
  end

  def print_name
    name
  end

  def print_children_name
  end
end

# Leaf Class
class Task < Entry
  def initialize(name, time)
    super(name)
    @time_required = time
  end

  def get_time_required
    @time_required
  end

  def print_name
    puts "タスク: #{name}"
  end
end

# Composite Class
class Project < Entry
  def initialize(name)
    super(name)
    @list = []
  end

  def add(project_or_task)
    @list << project_or_task
  end

  def remove(project_or_task)
    @list.delete(project_or_task)
  end

  def get_time_required
    @list.inject(0) {|time, child| time += child.get_time_required }
  end

  def total_number_basic_tasks
    @list.inject(0) {|time, child| time += child.total_number_basic_tasks }
  end

  def print_name
    puts "プロジェクト: #{name}"
  end

  def print_children_name
    @list.each do |child|
      child.print_name
      child.print_children_name
    end
  end
end

study_design_pattern = Project.new("デザパタ勉強会を行う")

template_pattern = Project.new("テンプレートパターンの会")
strategy_pattern = Project.new("ストラテジーパターンの会")
observer_pattern = Project.new("オブザーバーパターンの会")
study_design_pattern.add template_pattern
study_design_pattern.add strategy_pattern
study_design_pattern.add observer_pattern

template_pattern_task_1 = Task.new("本を読む", 15)
template_pattern_task_2 = Task.new("コードを書く", 30)
template_pattern.add template_pattern_task_1
template_pattern.add template_pattern_task_2

strategy_pattern_task_1 = Task.new("本を読む", 20)
strategy_pattern_task_2 = Task.new("コードを書く", 40)
strategy_pattern.add strategy_pattern_task_1
strategy_pattern.add strategy_pattern_task_2

observer_pattern_task_1 = Task.new("本を読む", 30)
observer_pattern_task_2 = Task.new("コードを書く", 40)
observer_pattern.add observer_pattern_task_1
observer_pattern.add observer_pattern_task_2

puts "所要時間: #{study_design_pattern.get_time_required}分"
puts "タスクの数: #{study_design_pattern.total_number_basic_tasks}"
study_design_pattern.print_children_name
