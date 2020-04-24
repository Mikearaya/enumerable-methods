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

    index = 0
    array = []

    while index < size
      array.push(self[index]) if yield(self[index]) == true
      index += 1
    end
    array
  end
end

my_hash = {
  name: 'Mikael Araya',
  phone: '0912333333'
}

my_hash.my_each { |index, value| puts "index = #{index} value => #{value}" }
