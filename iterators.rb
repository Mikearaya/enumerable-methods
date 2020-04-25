module Enumerable
  def my_each
    index = 0
    while index < size

      case self.class.name
      when 'Hash' then yield(keys[index], self[keys[index]])
      when 'Array' then yield(self[index])
      when 'Range' then yield(to_a[index])
      end
      index += 1
    end
  end

  def my_each_with_index
    index = 0
    while index < size
      yield(self[index], index)
      index += 1
    end
  end

  def my_select
    array = []
    my_each do |element|
      array.push(element) if yield(element) == true
    end
    array
  end

  def my_all?
    my_each do |val|
      return false unless yield(val) or size.zero?
    end
    true
  end

  def my_any?
    my_each do |val|
      return true if yield(val)
    end
    false
  end

  def my_none?
    my_each do |val|
      return false if yield(val) and size.positive
    end
    true
  end

  def my_count(args = 0)
    if block_given?
      counter = 0
      my_each do |element|
        counter += 1 if yield(element)
      end
      counter
    elsif args.positive?
      filtered = my_select { |element| element == args }
      filtered.size
    else
      size
    end
  end

  def my_map(some_proc = nil)
    new_array = []
    if some_proc.is_a?(Proc)
      my_each { |element| new_array.push(some_proc.call(element)) }
    elsif block_given?
      new_array.push(yield(element))
    else
      return enum_for
    end
    new_array
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_inject(arg1 = nil, arg2 = nil)
    to_a unless is_a?(Array)
    accumulator = nil
    symbole = nil

    if arg1.is_a?(Numeric)
      accumulator = arg1
      symbole = arg2 if arg2.is_a?(Symbol)
    end
    symbole = arg1 if arg1.is_a?(Symbol)

    if !symbole.nil?
      my_each do |element|
        accumulator = accumulator ? accumulator.send(symbole, element) : element
      end
    else
      my_each do |element|
        accumulator = accumulator ? yield(accumulator, element) : element
      end
    end
    accumulator
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end

def multiply_els(array)
  array.my_inject { |memo, current| memo * current }
end

puts 'my_inject TEST using multiply_els method with array  [2, 4, 5] Call'
puts multiply_els([2, 4, 5])

ary = [1, 2, 4, 2]
puts "Count test => #{ary}"
puts ary.count #=> 4
puts ary.count(2) #=> 2
puts ary.count(&:even?) #=> 3

puts 'my_map Test'
result = (1..4).map { |i| i * i }
p result #=> [1, 4, 9, 16]
result = (1..4).map { 'cat' }
p result #=> ["cat", "cat", "cat", "cat"]

longest = (5..10).my_inject(:+)
puts longest

longest = (5..10).my_inject { |sum, n| sum + n }
puts longest

longest = (5..10).my_inject(1, :*)
puts longest

longest = (5..10).my_inject(2) { |product, n| product * n }
puts longest

longest = %w[cat sheep bear].my_inject do |memo, word|
  memo.length > word.length ? memo : word
end
puts longest

def do_something_with_block(block)
  puts block.class
  puts block_given?
  block.call
end

say_something = -> { puts 'This is a lambda' }

puts do_something_with_block(say_something)
