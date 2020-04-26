# rubocop: disable Metrics/ModuleLength
# rubocop: disable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity
module Enumerable
  def my_each
    return to_enum :my_each unless block_given?

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
    return to_enum :my_each_with_index unless block_given?

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
    if pattern.nil?
      if block_given?
        my_each { |val| return false unless yield(val) or size.zero? }
      else my_each { |val| return false unless val }
      end
    elsif pattern.is_a?(Regexp)
      my_each { |val| return false unless val.match(pattern) }
    elsif pattern.is_a?(Module)
      my_each { |val| return false unless val.is_a?(pattern) }
    else
      my_each { |val| return false unless val == pattern }
    end
    true
  end

  def my_any?(pattern = nil)
    if pattern.nil?
      if block_given?
        my_each { |val| return true if yield(val) or size.zero? }
      else my_each { |val| return true if val }
      end
    elsif pattern.is_a?(Regexp)
      my_each { |val| return true if val.match(pattern) }
    elsif pattern.is_a?(Module)
      my_each { |val| return true if val.is_a?(pattern) }
    else
      my_each { |val| return true if val == pattern }
    end
    false
  end

  def my_none?(pattern = nil)
    if pattern.nil?
      if block_given?
        my_each { |val| return false if yield(val) or size.zero? }
      else my_each { |val| return false if val }
      end
    elsif pattern.is_a?(Regexp)
      my_each { |val| return false if val.match(pattern) }
    elsif pattern.is_a?(Module)
      my_each { |val| return false if val.is_a?(pattern) }
    else
      my_each { |val| return false if val == pattern }
    end
    true
  end

  def my_count(args = nil)
    if block_given?
      counter = 0
      my_each do |element|
        counter += 1 if yield(element)
      end
      counter
    elsif !args.nil?
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
      return to_enum :my_map
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
  alias my_reduce my_inject
end
# rubocop: enable Metrics/ModuleLength
# rubocop: enable Metrics/PerceivedComplexity, Metrics/CyclomaticComplexity

def multiply_els(array)
  array.my_inject { |memo, current| memo * current }
end
