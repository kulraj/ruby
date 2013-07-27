<<-doc
 10 Hash - Inject
Write a method that groups the above hash into 2 groups of 'even' and 'odd' length using 'inject'.
Eg: ['abc','def',1234,234,'abcd','x','mnop',5,'zZzZ'] -> {"odd"=>[["x", 5], ["abc", "def", 234]], "even"=>[[1234, "abcd", "mnop", "zZzZ"]]}
doc

class Array
  def group_by_even_odd
    key_length_hash = {}
    # group items by their length
    for item in self
      key_length_hash[item.length] = [] if !key_length_hash.has_key?(item.length)
      key_length_hash = key_length_hash.merge(Hash[item.length, key_length_hash[item.length].push(item)])
    end
    # group items by even or odd length
    even_odd_hash = key_length_hash.inject({"odd" => [], "even" => []}) do |even_odd_hash,(key,value)|
      even_odd_hash["even"].push(value) if key % 2 == 0
      even_odd_hash["odd"].push(value) if key % 2 == 1
      even_odd_hash
   end
   even_odd_hash
  end
end

puts "enter the strings separated by whitespaces"
array = gets.split(" ")
even_odd_hash = array.group_by_even_odd
puts even_odd_hash
