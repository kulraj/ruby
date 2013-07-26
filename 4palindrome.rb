puts "enter the string to check. enter q to quit"
begin
  string = gets.delete "\n"
  break if string.match(/^q$/i)
  puts string.reverse == string ? "it is palindrome" : "it is not palindrome"
end while true
