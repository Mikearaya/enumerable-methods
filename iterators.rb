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
end

my_hash = {
  name: 'Mikael Araya',
  phone: '0912333333'
}

[1, 2, 3, 4, 5].my_each { |index| puts "index = #{index}" }

my_hash.my_each { |index, value| puts "index = #{index} value => #{value}" }
