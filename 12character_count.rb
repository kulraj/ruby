<<-doc
12 Character Count - Ranges
Write a method that returns the no of various lowercase, uppercase, digits and special characters used in the string. Make use of Ranges.
doc

class String
  def character_count
    # ranges defined as per ascii values
    lowercase_range = Range.new('a','z')
    uppercase_range = Range.new('A','Z')
    digit_range = Range.new('0','9')
    special_character_range = Range.new('!','@')
    #count initialized
    uppercase_count = 0
    lowercase_count = 0
    digit_count = 0
    special_character_count = 0
    self.split("").each do |item|
      uppercase_count += 1 if uppercase_range.include?item
      lowercase_count += 1 if lowercase_range.include?item
      digit_count += 1 if digit_range.include?item
      # the defined range for special characters includes digits also so we need to exclude the results for digit 
      special_character_count += 1 if special_character_range.include?item and !digit_range.include?item
    end
    return [lowercase_count, uppercase_count, digit_count, special_character_count]
  end
end

puts "enter the string: "
string = gets
count_array = string.character_count
puts "lowercase characters = #{count_array[0]}"
puts "uppercase characters = #{count_array[1]}"
puts "digits = #{count_array[2]}"
puts "special characters = #{count_array[3]}" 
