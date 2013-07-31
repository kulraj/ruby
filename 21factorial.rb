# Add exception handling for negative numbers in factorial program.

class Integer
  def factorial
    (1..ord).inject(1) { |prod, i| prod * i }
  end
end

puts "enter the number"
number = gets.chomp
raise RuntimeError, "input not an integer" if !number.match(/[+-]?\d+/)
raise RuntimeError, "negative value entered" if (number.to_i < 0)
print "factorial = ", number.to_i.factorial, "\n"
