require './iterators.rb'
describe 'Iterators' do
  let(:number) { [1, 2, 3, 4, 2] }
  let(:string) { %w[cat bear rat] }
  context '#my_all?' do
    it 'Return true when no block is given' do
      expect(number.my_all?).to eq true
    end

    it 'Return false if all checks do not pass' do
      expect(number.my_all? { |a| a > 3 }).not_to eq true
    end

    it 'Return true when all checks pass' do
      expect(number.my_all? { |a| a > 0 }).to eq true
    end
    it 'Return true when all elements belong to same datatype' do
      expect(number.my_all?(Numeric)).to eq true
    end

    it 'Return false when some elements dont belong to same datatype' do
      expect(number.my_all?(String)).not_to eq true
    end

    it 'Return true when all elements match pattern' do
      expect(string.my_all?(/a/i)).to eq true
    end

    it 'Return false when some elements do not match pattern' do
      expect(string.my_all?(/t/i)).not_to eq true
    end
  end

  context '#my_any?' do
    it 'Return true when no block is given' do
      expect(number.my_any?).to eq true
    end

    it 'Return if any of checks pass' do
      expect(number.my_any? { |a| a > 3 }).to eq true
    end

    it 'Return false when all checks fail' do
      expect(number.my_any? { |a| a < 0 }).to eq false
    end
    it 'Return true when some elements belong to same datatype' do
      expect(number.my_any?(Numeric)).to eq true
    end

    it 'Return false when all elements dont belong to same datatype' do
      expect(number.my_any?(String)).not_to eq true
    end

    it 'Return true when any elements match pattern' do
      expect(string.my_any?(/c/i)).to eq true
    end

    it 'Return false when no element match pattern' do
      expect(string.my_any?(/y/i)).not_to eq true
    end
  end

  context '#my_count? should Return ' do
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
end
