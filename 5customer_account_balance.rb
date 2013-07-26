class Customer
  @@account_no = 0
  def initialize(name)
    @@account_no += 1 #auto increment account number
    @name = name
    @account_no = @@account_no
    @balance = 1000
  end
  def deposit(amount)
    @balance += amount
  end
  def withdrawal(amount)
    if @balance > amount
      @balance -= amount
    else
      puts "insufficient balance for withdrawal"
    end
  end
  def display
    puts "name: " + @name + ", account_no: " + @account_no.to_s + ", balance: " + @balance.to_s
  end
end

customer1 = Customer.new("abc")
customer1.display
customer1.deposit(1000)
customer1.display
customer2 = Customer.new("def")
customer2.display
customer1.withdrawal(3700)
customer1.display
customer1.withdrawal(700)
customer1.display
