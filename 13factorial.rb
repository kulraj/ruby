class Integer
  def factorial
    product = 1
    # ord function gives value of the number object, so this is loop from 1 to the number
    (1..self).each {|i| product *= i}
    product
  end
end

puts "enter the number"
number = gets.to_i
unless number >= 0
  puts "negative number entered"
else
  print "the factorial of ", number, " = ", number.factorial,"\n"
end
