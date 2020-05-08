require './iterators.rb'
describe 'Iterators' do
  let(:number) { [1, 2, 3, 4] }
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

    it 'Return true when wll elements match pattern' do
      expect(string.my_all?(/a/i)).to eq true
    end

    it 'Return false when some elements do not match pattern' do
      expect(string.my_all?(/t/i)).not_to eq true
    end
  end
end
