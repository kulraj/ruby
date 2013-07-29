#Overwrite the default 'to_s' method such that it inverses the case of each letter.
#Eg: "hello WORLD".to_s -> "HELLO world"

class String
  def to_s
    self.swapcase
  end
end

printf("enter the string: ")
input_string = gets
inverted_case_string = input_string.to_s
puts inverted_case_string
