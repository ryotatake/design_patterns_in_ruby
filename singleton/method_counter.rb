require 'singleton'

class MethodCounter
  include Singleton
  attr_reader :counter

  def initialize
    @counter = {}
  end

  def count(class_name, method_name)
    key = "#{class_name}_#{method_name}"
    @counter[key] ||= 0
    @counter[key] += 1
  end
end

class Hoge
  def initialize
    MethodCounter.instance.count(self.class.name, __method__)
  end

  def hoge
    puts "hoge"
    MethodCounter.instance.count(self.class.name, __method__)
  end
end

class Fuga
  def fuga
    puts "fuga"
    MethodCounter.instance.count(self.class.name, __method__)
  end
end

hoge = Hoge.new
hoge.hoge
hoge.hoge
hoge.hoge

fuga = Fuga.new
fuga.fuga
fuga.fuga

p MethodCounter.instance.counter
