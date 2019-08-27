# bad pattern
puts "========= bad pattern ========="

fruits = ['apple', 'banana', 'grape', 'orange']

fruits.each do |fruit|
  puts fruit
  fruits.delete fruit if fruit == 'banana'
end

p fruits


# good pattern 1
puts "========= good pattern 1 ========="

fruits = ['apple', 'banana', 'grape', 'orange']
_fruits = Array.new(fruits)

_fruits.each do |fruit|
  puts fruit
  fruits.delete fruit if fruit == 'banana'
end

p fruits


# good pattern 2
puts "========= good pattern 2 ========="

fruits = ['apple', 'banana', 'grape', 'orange']
_fruits = []

while fruit = fruits.pop
  puts fruit
  _fruits.unshift fruit unless fruit == 'banana'
end

p _fruits

# good pattern 3
puts "========= good pattern 3 ========="

fruits = ['apple', 'banana', 'grape', 'orange']

fruits.delete_if do |fruit|
  puts fruit
  fruit == 'banana'
end

p fruits
