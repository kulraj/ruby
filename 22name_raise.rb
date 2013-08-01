<<-doc
Create a class 'Name' with two attributes firstname and lastname. Neither of them can be null and the first letter of firstname must be capital. Implement using 'raise'.
doc

class Name
  def initialize(firstname, lastname)
    check_null(firstname.strip)
    raise RuntimeError, "first letter should be capital" if (firstname[0].match(/[a-z]/))
    check_null(lastname.strip)
    @firstname = firstname
    @lastname = lastname
  end
  def show
    print "welcome ", @firstname, " ", @lastname, "\n"
  end
  def check_null(name)
    raise RuntimeError, "null entry" if name == ""
  end
end



print "enter first name: "
firstname = gets.chomp
print "enter last name: "
lastname = gets.chomp
person1 = Name.new(firstname, lastname)
person1.show

