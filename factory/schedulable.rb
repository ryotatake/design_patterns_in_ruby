class Task
  attr_accessor :title

  def initialize(title)
    @title = title
  end
end

class Event
  attr_accessor :title

  def initialize(title)
    @title = title
  end
end

class Factory
  def create_and_output_schedulables
    output_head
    create_schedulables
    output_schedulables
  end

  def output_head
    raise NotImplementedError
  end

  def create_schedulables
    @schedulables = []

    while title = gets
      @schedulables << new_schedulable(title)
    end
  end

  def output_schedulables
    puts "=" * 20
    puts @schedulables.first.class

    @schedulables.each do |schedulable|
      puts "タイトル: #{schedulable.title}"
    end

    puts "=" * 20
  end
end

class TaskFactory < Factory
  def output_head
    puts "タスクのタイトルを入力してください"
  end

  def new_schedulable(title)
    Task.new(title)
  end
end

class EventFactory < Factory
  def output_head
    puts "予定のタイトルを入力してください"
  end

  def new_schedulable(title)
    Event.new(title)
  end
end

factory = TaskFactory.new
factory.create_and_output_schedulables
puts "\n"

factory = EventFactory.new
factory.create_and_output_schedulables
