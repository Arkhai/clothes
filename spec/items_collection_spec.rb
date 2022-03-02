require 'items_collection'
require 'item'

describe ItemsCollection do
  let(:items) do
    [
      Item.new(name: 'Шапка-ушанка', type: 'Головной убор', min_temp: -20, max_temp: 0),
      Item.new(name: 'Пальто', type: 'Верхняя одежда', min_temp:  -5, max_temp: 10),
      Item.new(name: 'Панамка', type: 'Головной убор', min_temp:  0, max_temp: 40)
    ]
  end

  let(:items_collection) do
    described_class.new(items)
  end

  describe '.from_dir' do
    let(:items_collection_from_dir) { ItemsCollection.from_dir('spec/fixtures') }
    let(:items_from_dir) { items_collection_from_dir.items_collection.sort_by(&:name) }

    it 'shoud return that it is an ItemsCollection example' do
      expect(items_collection_from_dir).to be_a ItemsCollection
    end

    it 'should return quantity of created items from dir' do
      expect(items_collection_from_dir.items_collection.size).to eq 3
    end

    it 'shoud return if each item is an Item example' do
      expect(items_collection_from_dir.items_collection).to all be_a Item
    end

    it 'shoud return first item in sorted array' do
      expect(items_from_dir.first).to have_attributes(name: "Кроссовки", type: "Обувь", min_temp: 0, max_temp: 15)
    end

    it 'shoud return last item in sorted array' do
      expect(items_from_dir.last).to have_attributes(name: "Шлепанцы", type: "Обувь", min_temp: 20, max_temp: 40)
    end
  end

  describe '.new' do
    it 'shoud return that it is an Array' do
      expect(items_collection.items_collection).to be_a Array
    end

    it 'shoud return if each piece of the collection is Item' do
      expect(items_collection.items_collection).to eq items
    end
  end

  describe '#suitable_items(degrees)' do
    context 'when suitable clothes for temperature does not exist' do
      it 'should return true' do
        [-21, 41].each do |i|
          expect(items_collection.suitable_items(i).empty?).to be true
        end
      end
    end

    context 'when suitable clothes for temperature exist' do
      it 'should return false' do
        [-20, -5, 0, 40].each do |i|
          expect(items_collection.suitable_items(i).empty?).to be false
        end
      end

      it 'shoud return exact quantity & check if they are unique' do
        expect(items_collection.suitable_items(0).size).to eq 2
        expect(items_collection.suitable_items(0).map(&:type)).to match_array ['Головной убор', 'Верхняя одежда']
      end
    end
  end
end
