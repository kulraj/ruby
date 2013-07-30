<<-doc
Define a method power() for an array. It takes an argument 'x' and returns the array with elements raised to power 'x'. Try to make use of array functions.
Eg: [1,2,3,4,5,6].power(3) -> [1, 8, 27, 64, 125, 216]
doc

class Array
  def power(x)
    collect{|i| i ** x}
  end
end

puts "enter the array with values separated by whitespaces:"
array = gets.split(" ").map { |s| s.to_i }
printf ("enter the power: ");
power = gets.chomp
if !power.match(/^\d+$/)
  puts "entered power is not an integer"
  exit
end
array = array.power(power.to_i)
puts "the array raised to given power is:"
array.each do |item|
  printf("%d ",item)
end
printf("\n")
