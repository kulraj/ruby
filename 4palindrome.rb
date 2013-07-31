class String
  def palindrome?
    # compare string with its reverse in ignore case mode. casecmp returns zero if they match
    casecmp(reverse) == 0
  end
end

puts "enter the string to check. enter q to quit"
while
  string = gets.chomp
  break if string.match(/^q$/i)
  puts (string.palindrome?) ? "it is palindrome" : "it is not palindrome"
end
