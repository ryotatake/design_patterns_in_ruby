class Task
  attr_accessor :title

  def initialize(title)
    @title = title
  end
end

class Command
  def execute
  end
end

class ChangeTaskTitle < Command
  def initialize(task, new_title)
    @task = task
    @new_title = new_title
  end

  def execute
    @old_title = @task.title
    @task.title = @new_title
  end

  def unexecute
    if @old_title
      @task.title = @old_title
    end
  end
end

class MacroCommand  < Command
  def initialize
    @commands = []
  end

  def <<(command)
    @commands << command
  end

  def execute
    @commands.each(&:execute)
  end

  def undo
    @commands.pop.unexecute
  end

  def clear
    @commands.reverse_each(&:unexecute)
    @commands = []
  end
end

p task1 = Task.new("初期状態です")

change_title_1 = ChangeTaskTitle.new(task1, "1回変更しました")
change_title_2 = ChangeTaskTitle.new(task1, "2回変更しました")
change_title_3 = ChangeTaskTitle.new(task1, "3回変更しました")
change_title_4 = ChangeTaskTitle.new(task1, "4回変更しました")

commands = MacroCommand.new
commands << change_title_1
commands << change_title_2
commands << change_title_3
commands << change_title_4
commands.execute
p task1

commands.undo
p task1

commands.undo
p task1

commands.clear
p task1
