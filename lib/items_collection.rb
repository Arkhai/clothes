class ItemsCollection
  attr_reader :items_collection

  def self.from_dir(dir)
    items_collection = Dir[File.join(dir, "*")].map do |file|
      lines = File.readlines(file, chomp: true, encoding: 'UTF-8')
      temp_array = lines[2].delete("\(\)+").split(", ").map(&:to_i)
      Item.new(
        name: lines[0],
        type: lines[1],
        min_temp: temp_array[0],
        max_temp: temp_array[1]
      )
    end

    new(items_collection)
  end

  def initialize(items_collection = [])
    @items_collection = items_collection
  end

  def suitable_items(degrees)
    @items_collection.select { |item| item.suits_temperature?(degrees) }.shuffle.uniq(&:type)
  end
end
