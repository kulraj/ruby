<<-doc
Write a search method that searches for a letter or word in a user input string and highlights the searched element. Also it should display the total no of searches found.

Eg: If user enters string to be searched as "Can you can a can as a canner can can a can?" and word to be searched is 'can' then output should be:
(Can) you (can) a (can) as a (can)ner (can) (can) a (can)?
Total Occurences found: 7
doc

class String
  def highlight_and_count(search_word)
    count = 0
    # escape all characters except for alphabets, numbers and underscore
    search_word.gsub!(/[^\w]/) { |match| "\\" + match }
    puts gsub(/#{search_word}/i) { |match|
      count += 1
      "(" + match + ")"
    }
    puts "Total occurences found = #{count}"
  end
end

puts "enter string to be searched"
text_string = gets.chomp
puts "enter the word to be searched"
search_word = gets.chomp
text_string.highlight_and_count(search_word)
