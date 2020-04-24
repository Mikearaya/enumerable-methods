module Enumerable
  def my_each
    return unless block_given?

    index = 0
    if is_a?(Hash)
      keys = self.keys
      while index < keys.size
        yield(keys[index], self[keys[index]])
        index += 1
      end
    else

      while index < size
        yield(self[index])
        index += 1
      end
    end
  end
end
