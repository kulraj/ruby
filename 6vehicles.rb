<<-doc
Define a class named 'Vehicle' consisting of 'name','price' and methods for initialising and showing contents. The 'price' of Vehicle may change over time. Now create a subclass 'Bike' having 'dealer' and method to show its content. Initialise a Bike class object with certain values and then change its price
doc

class Vehicle
  def initialize(name, price)
    @name = name
    @price = price
  end
  def price=(price)
    @price = price
  end
  def show
    printf("name: %s, price= %d", @name, @price)
  end
end

class Bike < Vehicle
  def initialize(name, price, dealer)
    super(name, price)
    @dealer = dealer
  end
  def price=(price)
    super(price)
  end
  def show
    super
    printf(", dealer: %s\n", @dealer)
  end
end

hayabusa = Bike.new("hayabusa", 1000, "lucky")
hayabusa.show
puts "enter the new price"
hayabusa.price = gets.to_i
hayabusa.show

