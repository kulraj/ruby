<<-doc
Create a class Interest that gives the user the difference in amount calculated simply and compoundedly. Initialise class with a block. 'p' and 't' are entered by user. Take 'r' = 10% pa.
doc

class Interest
  def initialize(name, principal, time, &block)
    @name, @block = name, block
    @p = principal.to_i
    @t = time.to_f
    @r = 10
  end
  def difference()
    "difference amount = #{ @block.call(@p, @r, @t) } Rs"
  end
end

print "Enter the principal: "
principal = gets.chomp
print "Enter the time in years: "
time = gets.chomp
regex_for_integer = /^\d+$/
regex_for_float = /^\d+([.]\d+)?$/
# validate principal and time
unless principal.match(regex_for_integer) && time.match(regex_for_float)
  puts "invalid value entered"
  else
  interest = Interest.new("interest difference", principal, time) do |principal, rate, time|
    # calculate simple and compound interest with the formula
    simple_interest = principal * rate * time / 100
    compound_interest = principal * (1 + rate.to_f/100) ** time - principal
    # find the difference to two places and round to two places after decimal
    (compound_interest - simple_interest).round(2)
  end
  print interest.difference()
end
