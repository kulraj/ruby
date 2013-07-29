def factorial(number, product)
  (1..number).each {|i| product *= i}
  printf("the factorial of %d = %d\n", number, product)
end

puts "enter the number"
number = gets.to_i
factorial(number, 1) 
