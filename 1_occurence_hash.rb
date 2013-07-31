def occurence_characters(string)
  hash = {}
  string.scan(/[a-z]/).each {|item| hash.merge!({item => (hash[item] || 0) + 1})}
  hash
end

string = gets.chomp
puts occurence_characters(string.downcase)
