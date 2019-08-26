class ArrayIterator
  def initialize(array)
    @array = array
    @index = 0
  end

  def has_next?
    @index < @array.length
  end

  def item
    @array[@index]
  end

  def next_item
    value = @array[@index]
    @index += 1
    value
  end
end

class Array
  def get_iterator
    ArrayIterator.new(self)
  end
end

def merge_with_external_iterator(array1, array2)
  merged = []

  iterator1 = ArrayIterator.new(array1)
  iterator2 = ArrayIterator.new(array2)

  while iterator1.has_next? && iterator2.has_next?
    if iterator1.item < iterator2.item
      merged << iterator1.next_item
    else
      merged << iterator2.next_item
    end
  end

  while iterator1.has_next?
    merged << iterator1.next_item
  end

  while iterator2.has_next?
    merged << iterator2.next_item
  end

  merged
end

def merge_without_iterator(array1, array2)
  merged = array1 + array2
  merged.sort
end



itr = ArrayIterator.new([1, 2, 3])

while itr.has_next?
  puts itr.next_item
end

array = ["a", "b", "c"]
itr2 = array.get_iterator

while itr2.has_next?
  puts itr2.next_item
end

#=============== mergeの速度を比較する ====================

require 'benchmark'

array1 = []
array2 = []
i = 0

1000000.times do
  array1 << i * 2
  array2 << i * 2 + 1
end

Benchmark.bm 10 do |r|
  r.report "external" do
    merge_with_external_iterator(array1, array2)
  end

  r.report "no iterator" do
    merge_without_iterator(array1, array2)
  end
end
 
Benchmark.bm 10 do |r|
  r.report "no iterator" do
    merge_without_iterator(array1, array2)
  end

  r.report "external" do
    merge_with_external_iterator(array1, array2)
  end
end
