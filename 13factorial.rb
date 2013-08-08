class Integer
  def factorial
    raise RuntimeError, "Negative value entered" if self < 0
    (1..self).inject(1) {|product, i| product *= i}
  end
end

puts "Enter the number"
number = gets.to_i
print "The factorial of #{number} =  #{number.factorial}\n"
