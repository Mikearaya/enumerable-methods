module Enumerable
  def my_each
    return unless block_given?

    index = 0
    while index < size

      case self.class.name
      when 'Hash' then yield(keys[index], self[keys[index]])
      when 'Array' then yield(self[index])
      end
      index += 1
    end
  end

  def my_each_with_index
    return unless block_given?

    index = 0
    while index < size
      yield(self[index], index)
      index += 1
    end
  end

  def my_select
    return unless block_given?

    array = []
    my_each do |element|
      array.push(element) if yield(element) == true
    end
    array
  end

  def my_all?
    return unless block_given?

    my_each do |val|
      return false unless yield(val) or size.zero?
    end
    true
  end

  def my_any?
    return unless block_given?

    my_each do |val|
      return true if yield(val)
    end
    false
  end

  def my_none?
    return unless block_given?

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
end

my_hash = {
  name: 'Mikael Araya',
  phone: '0912333333'
}

[1, 2, 3, 4, 5, 2, 7, 8].my_count(2) { |index, value| puts "index = #{index} value => #{value}" }

my_hash.my_each { |index, value| puts "index = #{index} value => #{value}" }
