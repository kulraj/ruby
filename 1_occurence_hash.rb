hash = {}
string = gets.delete "\n"
string.split("").each_with_index do |item, index|
  count = string.count item
  hash = hash.merge(Hash[item,count])
end
puts hash
