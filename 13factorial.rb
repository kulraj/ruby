class Integer
  def factorial
    if self < 0
      puts "Negative number entered"
      return "not defined"
    end
    (1..self).inject(1) {|product, i| product *= i}
  end
end

puts "Enter the number"
number = gets.to_i
print "The factorial of #{number} =  #{number.factorial}\n"
