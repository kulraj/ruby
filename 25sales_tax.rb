<<-doc
Sales Tax Problem: You have to write a program in Ruby which would calculate the sales tax on the items according to the following conditions:

a. Flat 10 % sales tax is applicable on all items except for book, food and medicine
b. Additional Import Duty of 5 % is applicable on all imported items without any exceptions

The input to the program would be in the following format..

Name of the product: Chocolates
Imported?: yes
Exempted from sales tax? yes
Price: 120
Do you want to add more items to your list(y/n): y

Name of the product: Potato Chips
Imported?: no
Exempted from sales tax?: yes
Price: 100
Do you want to add more items to your list(y/n): y

Name of the product: Perfume
Imported?: yes
Exempted from sales tax? no
Price: 150
Do you want to add more items to your list(y/n): n

You have to generate a list that would display the list in a nice format and the grand total should be rounded to the nearest integer
doc

class Invoice
  @@import_duty = 5
  @@sales_tax = 10

  def initialize(items)
    @item_list = items
  end

  def display_row(item, max_length_name)
    #print the data formatted column wise
    row_string = "| " + item.name.ljust(max_length_name, ' ') + " | "
    row_string.concat(item.imported.to_s.ljust("imported".length, ' ') + " | ")
    row_string.concat(item.exempted.to_s.ljust("exempted".length, ' ') + " | ")
    row_string.concat(item.price.to_s.ljust(" price ".length, ' ') + " | ")
    print row_string
  end
  def effective_price(item)
    #add taxes to the price, round to 2 places after decimal and return 
    price = item.price
    price *= 1 + @@sales_tax/100.to_f if item.exempted =~ /no/i
    price *= 1 + @@import_duty/100.to_f if item.imported =~ /yes/i
    price.round(2)
  end
  def generate_bill(max_length_name)
    grand_total = 0
    # we count the spaces before grand total and total columns in our output
    number_of_spaces = max_length_name + "imported | exempted |  price ".length + "grand total".length
    number_of_underscores = max_length_name + "  | imported | exempted |  price  | price including tax |  ".length
    # we use rjust and ljust for formatting the output
    print " \n".rjust(number_of_underscores, "_")
    print "| ","name".ljust(max_length_name + 1,' '), "| imported | exempted |  price  | price including tax | \n"

    @item_list.each do |item|
      display_row(item, max_length_name)
      effective_price = effective_price(item)
      print effective_price.to_s.ljust("price including tax".length, ' '), " |\n"
      grand_total += effective_price
    end
    print "\n", ("grand total | " + grand_total.round.to_s).rjust(number_of_spaces, ' '), "\n"
  end
end

class Item
  attr_reader :name, :imported, :exempted, :price

  def initialize(name, imported, exempted, price)
    @name = name
    @imported = imported
    @exempted = exempted
    @price = price.to_f
  end
  
end

#initialize the variables
item_number = 0
items = []
max_length_name = "name".length
begin
  # input the details
  print "\nName of the product: "
  name = gets.chomp
  print "Imported?: "
  imported = gets.chomp
  print "Exempted from sales tax? "
  exempted = gets.chomp
  print "Price: "
  price = gets.chomp
  print "Do you want to add more items to your list(y/n): "
  continue_choice = gets.chomp
  #price should be integer
  raise RuntimeError, "entered price is not an integer" if  price !~ /^\d+/
  items[item_number] = Item.new(name, imported, exempted, price)
  # maximum length of name is useful in formatting
  max_length_name = items[item_number].name.length if max_length_name < items[item_number].name.length
  item_number += 1
end while continue_choice =~ /^y$/i

invoice = Invoice.new(items)
invoice.generate_bill(max_length_name)
