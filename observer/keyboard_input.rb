module Subject
  def initialize
    @observers = []
  end

  def add_observer(observer)
    @observers << observer
  end

  def delete_observer(observer)
    @observers.delete(observer)
  end

  def notify_observers
    @observers.each do |observer|
      observer.update(self)
    end
  end
end

class Keyboard
  include Subject

  attr_reader :content

  def initialize
    super()
    @content = []
  end

  def input
    while line = gets
      @content << line
    end

    notify_observers
  end
end

class TextOutput
  def update(input)
    File.open("output.txt", "w") do |text|
      text.puts(input.content)
    end
  end
end

class LogOutput
  def update(input)
    File.open("output.log", "a") do |text|
      text.puts(input.content)
    end
  end
end

key = Keyboard.new
key.add_observer(TextOutput.new)
key.add_observer(LogOutput.new)
key.input
