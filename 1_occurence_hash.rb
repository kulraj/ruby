count_alphabet = 0
hash = {}
string = gets
string.split("").each_with_index do |item, index|
  count_alphabet += 1 if item.match(/^[[:alpha:]]$/)
  hash = hash.merge(Hash[index,item])
end
printf "number of alphabets in string = %d\n", count_alphabet
