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
      return false unless yield(val)
    end
    true
  end
end

my_hash = {
  name: 'Mikael Araya',
  phone: '0912333333'
}

z = [1, 2, 3, 4, 5, 6, 7, 8].my_all? { |value| value < 9 }
puts z
my_hash.my_each { |index, value| puts "index = #{index} value => #{value}" }
