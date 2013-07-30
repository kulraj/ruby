class Integer
  def factorial(product)
    # ord function gives value of the number object, so this is loop from 1 to the number
    (1..ord).each {|i| product *= i}
    product
  end
end

puts "enter the number"
number = gets.to_i
print "the factorial of ", number, " = ", number.factorial(1),"\n" 
