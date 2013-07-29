def occurence_characters(string)
  hash = string.downcase.scan(/[a-z]/).group_by {|item| item.match(/^[a-z]$/)}
  hash.map {|k,v| hash[k] = v.length}
  hash
end

string = gets.chomp
puts occurence_characters(string)
