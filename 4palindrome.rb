class String
  def palindrome
    # compare string with its reverse in ignore case mode. casecmp returns zero if they match
    puts casecmp(reverse) == 0 ? "it is palindrome" : "it is not palindrome"
  end
end

puts "enter the string to check. enter q to quit"
while
  string = gets.chomp
  break if string.match(/^q$/i)
  string.palindrome
end
