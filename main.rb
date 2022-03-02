require_relative 'lib/item'
require_relative 'lib/items_collection'

dir_path = File.join(__dir__, '/data')

collection = ItemsCollection.from_dir(dir_path)

puts 'What is the temperature outside? (possible with a minus)'

degrees = STDIN.gets.to_i

all_suitable = collection.suitable_items(degrees)

if all_suitable.empty?
  puts "Sorry, we don't have suitable clothes for the weather =("
else
  puts 'We suggest to wear today:'
  puts all_suitable
end
