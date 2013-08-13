<<-doc
Create a class Interest that gives the user the difference in amount calculated simply and compoundedly.
Initialise class with a block. 'p' and 't' are entered by user. Take 'r' = 10% pa.
doc

class Interest
  attr_accessor :p, :r, :t
  def initialize(&block)
    yield self
  end
  def simple_interest
    @p * @r * @t / 100
  end
  def compound_interest
    @p * (1 + @r.to_f/100) ** @t - @p
  end
  def difference
    (compound_interest - simple_interest).round(2)
  end
end

print "Enter the principal: "
principal = gets.chomp
print "Enter the time in years: "
time = gets.chomp
# validate principal and time
unless principal == principal.to_i.to_s && time == time.to_f.to_s
  puts "invalid value entered"
  else
  interest = Interest.new do |interest|
    interest.p = principal.to_i
    interest.t = time.to_f
    interest.r = 10
  end
  puts "Difference in the simple and compound interest = Rs #{interest.difference}"
end
