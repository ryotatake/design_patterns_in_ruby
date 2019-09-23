class Task
  attr_accessor :title, :description

  def initialize(title)
    @title = title
  end
end

class Event
  attr_accessor :title, :description

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

    while input = gets.chomp
      @schedulables << new_schedulable(input)
    end
  end

  def output_schedulables
    @schedulables.each do |schedulable|
      puts "タイトル: #{schedulable.title}"
  end
end

class TaskFactory < Factory
  def new_schedulable(title)
    Task.new(title)
  end
end
  #def new_schedulable(input)
  #  type, title = input.split
  #  Object.const_get(type).new(title)
  #end
