require './iterators.rb'
describe 'Iterators' do
  let(:number) { [1, 2, 3, 4, 2] }
  let(:string) { %w[cat bear rat] }
  context '#my_all? should Return' do
    it 'true when no block is given' do
      expect(number.my_all?).to eq true
    end

    it 'false when no block is given and one element is falsey' do
      expect([false, 1, 2, 3].my_all?).not_to eq true
    end

    it 'false if all checks do not pass' do
      expect(number.my_all? { |a| a > 3 }).not_to eq true
    end

    it 'true when all checks pass' do
      expect(number.my_all? { |a| a > 0 }).to eq true
    end
    it 'true when all elements belong to same datatype' do
      expect(number.my_all?(Numeric)).to eq true
    end

    it 'false when some elements dont belong to same datatype' do
      expect(number.my_all?(String)).not_to eq true
    end

    it 'true when all elements match pattern' do
      expect(string.my_all?(/a/i)).to eq true
    end

    it 'false when some elements do not match pattern' do
      expect(string.my_all?(/t/i)).not_to eq true
    end
  end

  context '#my_any? should return' do
    it 'true when no block is given' do
      expect(number.my_any?).to eq true
    end

    it 'false when no block is given and none is truthy' do
      expect([nil, false].my_any?).not_to eq true
    end

    it 'if any of checks pass' do
      expect(number.my_any? { |a| a > 3 }).to eq true
    end

    it 'false when all checks fail' do
      expect(number.my_any? { |a| a < 0 }).to eq false
    end
    it 'true when some elements belong to same datatype' do
      expect(number.my_any?(Numeric)).to eq true
    end

    it 'false when all elements dont belong to same datatype' do
      expect(number.my_any?(String)).not_to eq true
    end

    it 'true when any elements match pattern' do
      expect(string.my_any?(/c/i)).to eq true
    end

    it 'false when no element match pattern' do
      expect(string.my_any?(/y/i)).not_to eq true
    end
  end

  context '#my_count should Return ' do
    it 'number of item if when no arg given' do
      expect(number.my_count).to eq 5
    end
    it 'number of items equal to argument' do
      expect(number.my_count(2)).to eq 2
    end

    it 'number of items return true when block execute' do
      expect(number.my_count(&:even?)).to eq 3
    end
  end

  context '#my_filter should Return ' do
    it 'items that match block expression' do
      expect(number.my_filter(&:even?)).to match_array([2, 4, 2])
    end

    it 'enumerator when no block is given' do
      expect(number.my_filter).to be_instance_of(Enumerator)
    end
  end

  context '#my_select should Return ' do
    it 'items that match block expression' do
      expect(number.my_select(&:even?)).to all(be_even)
    end

    it 'enumerator when no block is given' do
      expect(number.my_select).to be_instance_of(Enumerator)
    end
  end

  context '#my_find_all should Return ' do
    it 'items that match block expression' do
      expect(number.my_find_all(&:even?)).to all(be_even)
    end

    it 'enumerator when no block is given' do
      expect(number.my_find_all).to be_instance_of(Enumerator)
    end
  end

  context '#my_inject should Return ' do
    it 'single result when passed a symbol' do
      expect((5..10).my_inject(:+)).to eq 45
    end

    it 'single result based on provided block result' do
      expect((5..10).my_inject { |sum, n| sum + n }).to eq 45
    end

    it 'single result based on value and symbol provided' do
      expect((5..10).my_inject(1, :*)).to eq 151_200
    end
    it 'single result based on value and block expression' do
      expect((5..10).my_inject(1) { |product, n| product * n }).to eq 151_200
    end

    it 'single result based on block expression' do
      longest = %w[cat sheep bear].my_inject do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(longest).to eq 'sheep'
    end
  end

  context '#my_reduce should Return ' do
    it 'single result when passed a symbol' do
      expect((5..10).my_reduce(:+)).to eq 45
    end

    it 'single result based on provided block result' do
      expect((5..10).my_reduce { |sum, n| sum + n }).to eq 45
    end

    it 'single result based on value and symbol provided' do
      expect((5..10).my_reduce(1, :*)).to eq 151_200
    end
    it 'single result based on value and block expression' do
      expect((5..10).my_reduce(1) { |product, n| product * n }).to eq 151_200
    end

    it 'single result based on block expression' do
      longest = string.my_reduce do |memo, word|
        memo.length > word.length ? memo : word
      end
      expect(longest).to eq 'bear'
    end
  end

  context '#my_none? should Return false when  ' do
    it 'some element match expression' do
      expect(string.my_none? { |word| word.size >= 4 }).not_to eq true
    end
    it 'some element match pattern' do
      expect(string.my_none?(/b/i)).not_to eq true
    end
    it 'some element are of  provided datatype' do
      expect(string.my_none?(String)).not_to eq true
    end

    it 'some element are are truthy' do
      expect([nil, false, true].none?).not_to eq true
    end
  end
  context '#my_none? should Return true when' do
    it 'no element match expression' do
      expect(string.my_none? { |word| word.size == 5 }).to eq true
    end
    it 'no element match pattern' do
      expect(string.my_none?(/z/i)).to eq true
    end
    it 'no element are are truthy' do
      expect([nil, false].none?).to eq true
    end
    it 'no element are of  provided datatype' do
      expect(string.my_none?(Integer)).to eq true
    end
  end

  context '#my_map should Return ' do
    it 'transformed array when block is given' do
      expect((1..4).my_map { |i| i * i }).to match_array [1, 4, 9, 16]
    end

    it 'enumerable when no block is given' do
      expect((1..4).my_map).to be_instance_of(Enumerator)
    end
  end

  context '#my_each_with_index should Return ' do
    it 'call block with two arguments (item & index)' do
      hash = {}
      %w[cat dog wombat].each_with_index do |item, index|
        hash[item] = index
      end
      expect(hash).to include('cat' => 0, 'dog' => 1, 'wombat' => 2)
    end
    it 'enumerable when no block is given' do
      expect((1..4).my_each_with_index).to be_instance_of(Enumerator)
    end
  end

  context '#my_each should Return ' do
    it 'enumerable when no block is given' do
      expect((1..4).my_each).to be_instance_of(Enumerator)
    end
    # rubocop:disable Lint/Void
    it 'should not modify the array' do
      expect((number.each { |x| x * x })).to match_array(number)
    end
    # rubocop:enable Lint/Void
    it 'to output to stdout' do
      expect { (number.each { |x| print x }) }.to output.to_stdout
    end
  end
end
