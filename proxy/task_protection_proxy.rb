require 'etc'

class TaskProtectionProxy
  def initialize(real)
    @real = real
  end

  def content
    check_access(FOLLOWERS)
    @real.content
  end

  def content=(content)
    check_access(REQUESTER)
    @real.content = content
  end

  def responder=(responder)
    check_access(RESPONDER)
    @real.responder = responder
  end

  # 特にaccess_levelを指定しないものはそのまま通す
  def method_missing(name, *args)
    @real.send(name, *args)
  end

  private

  def check_access(access_level)
    unless accessible?(access_level)
      raise "Illegal access: #{login_user} cannot access."
    end
  end

  def accessible?(access_level)
    case access_level
    when RESPONDER
      login_user == @real.responder
    when REQUESTER
      [@real.responder, @real.requester].include?(login_user)
    when FOLLOWERS
      [@real.responder, @real.requester, *@real.followers].include?(login_user)
    when ALL
      true
    end
  end

  def login_user
    Etc.getlogin
  end

  module AccessLevel
    ALL       = 0
    FOLLOWERS = 1
    REQUESTER = 2
    RESPONDER = 3
  end
  include AccessLevel
end

class Task
  attr_accessor :content, :responder, :requester, :followers

  def initialize(content, responder, requester, followers)
    @content = content
    @responder = responder
    @requester = requester
    @followers = followers
  end
end

puts "=========== login userがresponderの場合 ========== "

task = Task.new("内容です", "admin", "かとうさん", ["いとうさん", "さとうさん"])
proxy = TaskProtectionProxy.new(task)

puts "内容: #{proxy.content}"
puts "DRI: #{proxy.responder}"
puts "依頼者: #{proxy.requester}"
puts "関係者: #{proxy.followers.join(', ')}"

proxy.content = "fuga"
puts "内容: #{proxy.content}"
proxy.responder = "むとうさん"
puts "DRI: #{proxy.responder}"

puts "=========== login userがfollowerの場合 ========== "

task = Task.new("内容です", "いとうさん", "かとうさん", ["admin", "さとうさん"])
proxy = TaskProtectionProxy.new(task)

puts "内容: #{proxy.content}"
puts "DRI: #{proxy.responder}"
puts "依頼者: #{proxy.requester}"
puts "関係者: #{proxy.followers.join(', ')}"

proxy.content = "fuga"
puts "内容: #{proxy.content}"
proxy.responder = "むとうさん"
puts "DRI: #{proxy.responder}"

puts "=========== login userがfollowerにも入っていない場合 ========== "

task = Task.new("内容です", "いとうさん", "かとうさん", ["むとうさん", "さとうさん"])
proxy = TaskProtectionProxy.new(task)

puts "内容: #{proxy.content}"
