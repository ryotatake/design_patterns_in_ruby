# Component Class
class Task
  attr_accessor :name, :parent

  def initialize(name)
    @name = name
    @parent = nil
  end

  def get_time_required
    0.0
  end

  def total_number_basic_task
    1
  end

  def get_parents
    task = self

    while task
      puts "task: #{task}"
      task = task.parent
    end
  end
end

# Leaf Class
class AddDryIngredientsTask < Task
  def initialize
    super('Add dry ingredients')
  end

  def get_time_required
    1.0
  end
end

class AddLiquidsTask < Task
  def initialize
    super('Add Liquids')
  end

  def get_time_required
    1.0
  end
end

class MixTask < Task
  def initialize
    super('Mix that batter up!')
  end

  def get_time_required
    3.0
  end
end

# Composite Class
class CompositeTask < Task
  def initialize(name)
    super(name)
    @sub_tasks = []
  end

  def <<(task)
    @sub_tasks << task
    task.parent = self
  end

  def remove_sub_task(task)
    @sub_tasks.delete(task)
    task.parent = nil
  end

  def get_time_required
    @sub_tasks.inject(0.0) {|time, task| time += task.get_time_required }
  end

  def total_number_basic_tasks
    @sub_tasks.inject(0) {|total, task| total += task.total_number_basic_task}
  end
end

class MakeBatterTask < CompositeTask
  def initialize
    super('Make batter')
    self << AddDryIngredientsTask.new
    self << AddLiquidsTask.new
    self << MixTask.new
  end
end

class MakeCakeTask < CompositeTask
  def initialize
    super('Make cake')
    self << MakeBatterTask.new
    self << FillPanTask.new
    self << BakeTask.new
    self << FrostTask.new
    self << LickSpoonTask.new
  end
end
