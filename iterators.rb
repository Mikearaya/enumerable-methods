# rubocop:disable  Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
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
    return enum_for unless block_given?

    array = []
    my_each do |element|
      array.push(element) if yield(element) == true
    end
    array
  end
  alias my_find_all my_select
  alias my_filter my_select

  def my_all?(pattern = nil)
    is_equal = true
    if pattern.nil?
      if block_given?
        my_each { |val| is_equal = false unless yield(val) or size.zero? }
      else my_each { |val| is_equal = false unless val == true }
      end
    elsif pattern.is_a?(Module)
      if pattern.is_a?(Regexp)
        my_each { |val| is_equal = false unless pattern.match(val) }
      else
        my_each { |val| is_equal = false unless val.is_a?(pattern) }
      end
    end
    is_equal
  end

  def my_any?
    my_each do |val|
      return true if yield(val)
    end
    false
  end

  def my_none?(pattern = nil)
    is_true = true
    if pattern.nil?
      if block_given?
        my_each { |val| is_true = false if yield(val) or size.zero? }
      else my_each { |val| is_true = false if val == true }
      end
    elsif pattern.is_a?(Module)
      if pattern.is_a?(Regexp)
        my_each { |val| is_true = false if pattern.match(val) }
      else
        my_each { |val| is_true = false if val.is_a?(pattern) }
      end
    end
    is_true
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
      my_each { |element| new_array.push(yield(element)) }
    else
      return enum_for
    end
    new_array
  end

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
end
# rubocop:enable  Metrics/ModuleLength, Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity

def multiply_els(array)
  array.my_inject { |memo, current| memo * current }
end

puts 'my_inject TEST using multiply_els method with array  [2, 4, 5] Call'
puts multiply_els([2, 4, 5])

ary = [1, 2, 4, 2]
puts "Count test => #{ary}"
puts ary.my_count #=> 4
puts ary.my_count(2) #=> 2
puts ary.my_count(&:even?) #=> 3

puts 'my_map Test'
result = (1..4).my_map { |i| i * i }
p result #=> [1, 4, 9, 16]
result = (1..4).my_map { 'cat' }
p result #=> ["cat", "cat", "cat", "cat"]

puts "\nmy_each_with_index Test"
hash = {}
%w[cat dog wombat].my_each_with_index do |item, index|
  hash[item] = index
end
puts hash

puts "\n my_select and my_filter TEST"
result = (1..10).my_find_all { |i| (i % 3).zero? } #=> [3, 6, 9]
p result
result = [1, 2, 3, 4, 5].my_select(&:even?) #=> [2, 4]
p result
result = %i[foo bar].my_filter { |x| x == :foo } #=> [:foo]
p result

longest = (5..10).my_inject(:+)
p longest

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

puts "\n my_all? TEST"

result = %w[ant bear cat].my_all? { |word| word.length >= 3 } #=> true
p result
result = %w[ant bear cat].my_all? { |word| word.length >= 4 } #=> false
p result
p %w[ant bear cat].my_all?(/t/) #=> false
p [1, 2i, 3.14].my_all?(Numeric) #=> true
p [nil, true, 99].my_all? #=> false
p [].my_all?

puts "\n my_none? TEST"
result = %w[ant bear cat].none? { |word| word.length == 5 } #=> true
p result
result = %w[ant bear cat].none? { |word| word.length >= 4 } #=> false
p result
p %w[ant bear cat].none?(/d/) #=> true
p [1, 3.14, 42].none?(Float) #=> false
p [].none? #=> true
p [nil].none? #=> true
p [nil, false].none? #=> true
