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
      case item
      when 'A'..'Z'
        uppercase_count += 1
      when 'a'..'z'
        lowercase_count += 1
      when '0'..'9'
        digit_count += 1
      else
        special_character_count += 1 if item != ' '
      end
    end
    return [lowercase_count, uppercase_count, digit_count, special_character_count]
  end
end

puts "enter the string: "
string = gets.chomp
count_array = string.character_count
puts "lowercase characters = #{count_array[0]}"
puts "uppercase characters = #{count_array[1]}"
puts "digits = #{count_array[2]}"
puts "special characters = #{count_array[3]}" 
