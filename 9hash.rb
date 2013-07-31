<<-doc
Create a method for Array that can create a hash having 'key' as length of the element and value as an array of all the elements of that length. Make use of for-in loop for the purpose.
Eg: ['abc','def',1234,234,'abcd','x','mnop',5,'zZzZ'] should give result as {3=>["abc", "def", 234], 4=>[1234, "abcd", "mnop", "zZzZ"], 1=>["x", 5]}
doc

class Array
  def key_length(hash)
    for item in self
      hash[item.length] = [] if !hash.has_key?(item.length)
      hash = hash.merge(Hash[item.length, hash[item.length].push(item)])
    end
    hash
  end
end

puts "enter the strings separated by whitespaces"
array = gets.split(" ")
hash = array.key_length({})
puts hash
