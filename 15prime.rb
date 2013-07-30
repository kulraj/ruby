# Define a method to find all prime numbers upto n using 'step' function.
require "prime"

class Integer
  def generate_prime_numbers
    #loop 2 to n and check if the current number is prime?
    (2..ord).step(1) { |i| print i," " if Prime.prime?(i) }
  end
end

puts "enter the number upto which to check prime"
n = gets.chomp
unless n.match(/^\d+$/)
  puts "input is not an integer"
  else
  n.to_i.generate_prime_numbers
end



