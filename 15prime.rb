# Define a method to find all prime numbers upto n using 'step' function.

class Integer
  def is_prime?
  #check divisibility by 2 to number/2    
  (2..ord/2).step(1) {|i| return false if ord % i == 0}
  end
end

puts "enter the number upto which to check prime"
n = gets.to_i
#loop 2 to n and check if the current number is prime?
(2..n).step(1) {|i| print i," " if i.is_prime?}
