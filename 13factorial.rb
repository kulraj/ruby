class Integer
  def factorial
    unless self >= 0
      puts "Negative number entered"
      exit
    else
      product = 1
      # loop from 1 to the number
      (1..self).each {|i| product *= i}
      product
    end
  end
end

puts "Enter the number"
number = gets.to_i
print "The factorial of #{number} =  #{number.factorial}\n"
