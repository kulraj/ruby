<<-doc
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
doc

developers_string = "Developers:\n"
designers_string = "Designers:\n"
File.open("read_file", "r") do |file|
  while line = file.gets
    employee_info = line.chomp.split(", ")
    # employee_info[0] contains name, employee_info[1] contains id and employee_info[2] contains the profile
    employee_info_string = employee_info[0] + " (Empid:" + employee_info[1] + ")\n"
    # club all developers into one string and all designers into one string
    if (employee_info[2] == "Developer")
      developers_string.concat(employee_info_string)
    else
      designers_string.concat(employee_info_string)
    end  
  end
end

#write the strings to the other file
File.open("write_file", "w") do |file|
  file.print designers_string, "\n", developers_string
end
