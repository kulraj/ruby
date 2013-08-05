class Customer
  @@account_number = 0
  @@customer = []
  def initialize(name)
    @@account_number += 1
    @name = name
    @account_number = @@account_number
    @balance = 1000
    @@customer << self
    display
  end
  def account_number
    @account_number
  end
  def Customer.search(account_number)
    @@customer.each { |customer| return customer if customer.account_number == account_number }
  end
  def deposit(deposit_amount)
    @balance += deposit_amount
    display
  end
  def withdrawal(withdrawal_amount)
    if @balance > withdrawal_amount
      @balance -= withdrawal_amount
    else
      puts "insufficient balance for withdrawal"
    end
    display
  end
  def display
    puts "name: #{@name} account_no: #{@account_number.to_s} balance: #{@balance.to_s}"
  end
end

def get_account_number
  puts "enter your account_number"
  gets.to_i
end

begin
  puts "Enter your choice:\n 1 for new customer\n 2 for deposit\n 3 for withdrawal\n 4 for quit"
  choice_of_operation = gets.to_i
  case choice_of_operation
  when 1
    puts "Welcome. Please enter your name"
    name = gets.chomp
    #new_account_number += 1
    Customer.new(name)
    #customer[new_account_number] = Customer.new(name, new_account_number)
    #customer[new_account_number].display
  when 2
    puts "enter deposit amount"
    deposit_amount = gets.to_i
    account_number = get_account_number
#print Customer.instance_eval { @@customer }
    selected_customer = Customer.search(account_number)
    selected_customer.deposit(deposit_amount)
    #customer[account_number].display
  when 3
    puts "enter withdrawal amount"
    withdrawal_amount = gets.to_i
    account_number = get_account_number
    selected_customer = Customer.search(account_number)
    selected_customer.withdrawal(withdrawal_amount)
    #customer[account_number].withdrawal(withdrawal_amount)
    #customer[account_number].display
  when 4
    exit
  else
    puts "You gave me #{choice_of_operation} -- I have no idea what to do with that."
  end
end while choice_of_operation != 4
