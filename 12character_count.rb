<<-doc
12 Character Count - Ranges
Write a method that returns the no of various lowercase, uppercase, digits and special characters used in the string. Make use of Ranges.
doc

class String
  def character_count
    #count initialized
    uppercase_count = 0
    lowercase_count = 0
    digit_count = 0
    special_character_count = 0
    self.split("").each do |item|
      # we apply ranges as per their ascii values
      uppercase_count += 1 if ('A'..'Z').include?item
      lowercase_count += 1 if ('a'..'z').include?item
      digit_count += 1 if ('0'..'9').include?item
      # the range for special characters is divided into 4 parts
      special_character_count += 1 if ('!'..'/').include?item or (':'..'@').include?item or (']'..'`').include?item or ('{'..'~').include?item
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
