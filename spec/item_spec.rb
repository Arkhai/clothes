require 'item'

describe Item do
  let(:item) do
    described_class.new(name: 'Пальто', type: 'Верхняя одежда', min_temp: -5, max_temp: 10)
  end

  describe '.new' do
    it 'sets the attributes' do
      expect(item.name).to eq 'Пальто'
      expect(item.type).to eq 'Верхняя одежда'
      expect(item.min_temp).to eq -5
      expect(item.max_temp).to eq 10
    end
  end

  describe '#suits_temperature?(temperature)' do
    context 'when temperature is suitable' do
      it 'should return true' do
        [-5, 0, 10].each do |i|
          expect(item.suits_temperature?(i)).to be true
        end
      end
    end

    context 'when temperature is unsuitable' do
      it 'should return false' do
        [-6, 11].each do |i|
          expect(item.suits_temperature?(i)).to be false
        end
      end
    end
  end

  describe '#to_s' do
    it 'returns a formatted item description string' do
      expect(item.to_s).to eq("#{item.name} (#{item.type}) #{item.min_temp}..#{item.max_temp}")
    end
  end
end
