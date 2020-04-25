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

  def my_map
    return enum_for unless block_given?

    new_array = []
    my_each do |element|
      new_array.push(yield(element))
    end
    new_array
  end

  # rubocop:disable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
  def my_inject(arg1 = nil, arg2 = nil)
    to_a unless is_a?(Array)
    accumulator = 0
    symbole = nil

    if arg1.is_a?(Numeric)
      accumulator = arg1
      symbole = arg2 if arg2.is_a?(Symbol)
    end
    symbole = arg1 if arg1.is_a?(Symbol)

    if !symbole.nil?

      my_each do |element|
        accumulator = accumulator.send(symbole, element)
      end
    else
      my_each do |element|
        accumulator = accumulator.to_s if element.is_a?(String)
        accumulator = yield(accumulator, element)
      end
    end
    accumulator
  end
  # rubocop:enable Metrics/CyclomaticComplexity, Metrics/PerceivedComplexity
end
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
