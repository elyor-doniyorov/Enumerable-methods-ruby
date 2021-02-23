#spec/test.rb

require_relative '../b_blocks.rb'



describe Enumerable do
    describe '#my_each' do
      it 'return every value' do
        expect([5, 1].my_each { |i| i }).to eql([5, 1])
      end
      it 'Returns true if contains only nils and false' do
        expect([false, nil].my_none?).to eql(true)
      end
      it 'Returns true if contains only nils and false' do
        expect([true, false, nil].my_none?).to eql(false)
      end
      it 'return true if there are floats' do
        expect([21, 3, 4.32].my_none?(Float)).to eql(false)
      end
      it 'return true if word don t own letter' do
        expect(%w[ant bear car].my_none?(/s/)).to eql(true)
      end
      it 'Returns true if array is empty' do
        expect([].my_none?).to eql(true)
      end
      it 'Returns true if there are only nils' do
        expect([nil].my_none?).to eql(true)
      end
    end
  

  describe '#my_each_with_index' do
    it 'return enum if no block' do
      arr = [1, 2, 3, 4]
      expect(arr.my_each_with_index).to be_a(Enumerator)
    end

    it 'return array if block' do
      arr = [1, 2, 3, 4]
      expect(
        arr.my_each_with_index do |x, i|
        end
      ).to eql(arr)
    end

    it 'when empty enum no return nil' do
      expect([].my_each_with_index).not_to eql(nil)
    end

    it 'should return the sum of all indexes of the array ' do
      arr = [1, 2, 3, 4]
      total = 0
      arr.my_each_with_index do |_x, i|
        total += i
      end
      expect(total).to eql(6)
    end
  end

  describe '#my_select' do
    it 'Returns just the even numers' do
      expect([1, 2, 3, 4, 5, 6, 7, 8].my_select(&:even?)).to eql([2, 4, 6, 8])
    end
  end

  describe '#my_any?' do
    it 'Returns true if 3 characters or longer' do
      expect(%w[ant bear car].my_any? { |word| word.length >= 3 }).to eql(true)
    end
    it 'Returns true if any inputs are integers' do
      expect([true, nil, 99].my_any?(Integer)).to eql(true)
    end
    it 'Returns false if if has s' do
      expect(%w[ant bear car].my_any?(/s/)).to eql(false)
    end
    it 'Returns false if array is empty' do
      expect([].my_any?).to eql(false)
    end
    it 'Returns true if value of true' do
      expect([nil, true, 99].my_any?).to eql(true)
    end
  end
  it 'Returns true if 4 character or longer' do
    expect(%w[ant bear car].my_any? { |word| word.length >= 4 }).to eql(true)
  end
  describe '#my_none?' do
    it 'Returns false if none of have a lenght greater than or equal to 4' do
      expect(%w[ant bear car].my_none? { |word| word.length >= 4 }).to eql(false)
    end
    it 'Returns true if none have length of 5' do
      expect(%w[ant bear car].my_none? { |word| word.length == 5 }).to eql(true)
    end
  end
end
