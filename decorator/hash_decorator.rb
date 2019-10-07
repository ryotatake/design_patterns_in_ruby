require 'forwardable'

class HashDecorator
  extend Forwardable

  def_delegators :@hash, :[]

  def initialize(hash)
    @hash = hash
  end

  def formatted_output
    @hash.each_key do |key|
      puts "key: #{key}, value: #{@hash[key]}"
    end
  end

  def centered_value_output(key)
    puts @hash[key].center(20)
  end
end

hash = {:a => "hoge", :b => "fuga"}
decorator = HashDecorator.new(hash)
p decorator[:a]
decorator.formatted_output
