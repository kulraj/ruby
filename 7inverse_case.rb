#Overwrite the default 'to_s' method such that it inverses the case of each letter.
#Eg: "hello WORLD".to_s -> "HELLO world"

class String
  def to_s
    self.swapcase
  end
end

printf("enter the string: ")
string = gets
string = string.to_s
puts string
