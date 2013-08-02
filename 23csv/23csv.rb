=begin
Read a CSV file with the fields Name, EmpId, Designation.
John, 12, Developer
Mary, 13, Designer
Jack, 15, Developer
Jane, 17, Designer

Save into another file in the format:
Designers:
Mary (EmpId: 13)
Jane (EmpId: 17)

Developers
John (EmpId: 12)
Jack (EmpId: 15)
=end

require "csv"

class Employee
  def initialize(name, id, profile)
    @name = name
    @id = id
    @profile = profile
  end
  def to_s
    "#{@name} (Empid:#{@id})\n"
  end
  def profile
    @profile
  end
end

i = 0
employee = []

CSV.foreach("read_file.csv") do |employee_info|
  # employee_info is one row of the file
  # employee_info[0] contains name, employee_info[1] contains id and employee_info[2] contains the profile
  # we save the row as an object
  employee[i] = Employee.new(employee_info[0], employee_info[1], employee_info[2])
  i += 1
end

# partition by the profile
employee = employee.partition { |employee| employee.profile =~ /Designer/ }

#write the objects to the other file
File.open("write_file", "w") do |file|
  file.print "Designers:\n"
  employee[0].each { |employee_i| file.print employee_i.to_s }
  file.print "\nDevelopers:\n"
  employee[1].each { |employee_i| file.print employee_i.to_s }
end
