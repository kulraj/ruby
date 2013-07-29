<<-doc
12 Character Count - Ranges
Write a method that returns the no of various lowercase, uppercase, digits and special characters used in the string. Make use of Ranges.
doc

class String
  def character_count
    # ranges defined as per ascii values
    lowercase = Range.new('a','z')
    uppercase = Range.new('A','Z')
    digits = Range.new('0','9')
    special_characters = Range.new('!','@')
    #count initialized
    no_uppercase = 0
    no_lowercase = 0
    no_digits = 0
    no_special_characters = 0
    self.split("").each do |item|
      no_uppercase += 1 if uppercase.include?item
      no_lowercase += 1 if lowercase.include?item
      no_digits += 1 if digits.include?item
      # the defined range for special characters includes digits also so we need to exclude the results for digit 
      no_special_characters += 1 if special_characters.include?item and !digits.include?item
    end
  return [no_lowercase, no_uppercase, no_digits, no_special_characters]
  end
end

puts "enter the string: "
string = gets
count_array = string.character_count
puts count_array
