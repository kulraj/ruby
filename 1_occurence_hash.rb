def occurence_characters(string, hash)
  string.scan(/[a-z]/).each {|item| hash = hash.merge(Hash[item, string.count(item)])}
  hash
end

string = gets.chomp
puts occurence_characters(string.downcase, {})
