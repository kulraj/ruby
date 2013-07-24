hash = {}
string = gets
string.split("").each_with_index do |item, index|
  if item.match(/^[[:alpha:]]$/)
    count = string.count item
    hash = hash.merge(Hash[item,count])
  end
end
puts hash
