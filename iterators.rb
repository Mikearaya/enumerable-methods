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

  def my_inject
    return enum_for unless block_given?

    accumulator = 0
    my_each do |element|
      accumulator = yield(accumulator, element)
    end
    accumulator
  end
end

(5..10).inject { |sum, n| sum + n }
