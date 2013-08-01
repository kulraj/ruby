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

class Item
def initialize(name, imported, exempted, price)
@name = name
@imported = imported
@exempted = exempted
@price = price.to_i
end
def effective_price
price = @price.to_f
price *= 1.1 if @exempted =~ /no/i
price *= 1.05 if @imported =~ /yes/i
price
end
def show(max_length_name)
print "| ", @name.ljust(max_length_name, ' '), " | ", @imported.to_s.ljust("imported".length, ' '), " | ", @exempted.to_s.ljust("exempted".length, ' '), " | ", @price.to_s.ljust("price".length, ' '), " | "
end
def name
@name
end
end


grand_total = 0
item_number = 0
item = []
max_length_name = "name".length
begin
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
raise RuntimeError, "entered price is not an integer" if  price !~ /^\d+/
item[item_number] = Item.new(name, imported, exempted, price)
#puts item[item_number].name.length
max_length_name = item[item_number].name.length if max_length_name < item[item_number].name.length
#grand_total += item[item_number].effective_price
item_number += 1
end while continue_choice =~ /^y$/i

#puts max_length_name
#puts " _________________________________________________________"
print "| ","name".ljust(max_length_name + 1,' '), "| imported | exempted | price | price including tax | \n"
0.upto(item.length - 1) do |i|
item[i].show(max_length_name)
effective_price = item[i].effective_price
print effective_price.to_s.ljust("price including tax".length, ' '), " |\n"
grand_total += effective_price
end
number_of_spaces = max_length_name + " imported | exempted | price ".length + "grand total".length
print "\n", ("grand total | " + grand_total.to_s).rjust(number_of_spaces, ' '), "\n"
