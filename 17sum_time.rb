<<-doc
Write a method that sums up 2 24-hour time values(h:m:s). Validate the time using regular expressions.
Eg: ("0:45:34","0:15:58") -> 01:01:32 ; ("11:23:07","22:53:45") -> 1 day & 10:16:52
doc

def sum_time(first_time, second_time)
  # initialize the variables
  first_time_array = first_time.split(":")
  second_time_array = second_time.split(":")
  carry = 0
  sum = []
  sum_string = ""
  # start loop, first add seconds then minutes then hours
  2.downto(0) do |i|
    sum[i] = first_time_array[i].to_i + second_time_array[i].to_i + carry
    if i == 0 # hours
      days = sum[i] / 24
      sum[i] %= 24
      sum_string = days.to_s + " day & " if days > 0
    else # minutes and seconds
      carry = sum[i] / 60
      sum[i] %= 60
    end
    # prepend 0 to sum[i] if it has only 1 digit
    sum[i] = sum[i].to_s.rjust(2, '0')
  end
  # join sum array into single string and append to existing string
  sum_string.concat(sum.join(":")) 
end

puts "enter the first time value"
first_time = gets.chomp
puts "enter the second time value"
second_time = gets.chomp
regex_for_time = /^(([01]?\d)|(2[0-3]))([:]([0-5]?\d)){2}$/
#check for valid time
unless first_time.match(regex_for_time) && second_time.match(regex_for_time)
  puts "invalid time entered"
  else
  puts sum_time(first_time, second_time)
end
