<<-doc
Write a method that sums up 2 24-hour time values(h:m:s). Validate the time using regular expressions.
Eg: ("0:45:34","0:15:58") -> 01:01:32 ; ("11:23:07","22:53:45") -> 1 day & 10:16:52
doc

require "time"

def zerofill(time_component)
  time_component.to_s.rjust(2,'0')
end

def sum_time(first_timestamp, second_timestamp)
  hours = second_timestamp.hour + first_timestamp.hour
  minutes = second_timestamp.min + first_timestamp.min
  seconds = second_timestamp.sec + first_timestamp.sec
  minutes += (seconds / 60).to_i
  hours += (minutes / 60). to_i
  seconds %= 60
  minutes %= 60
  sum_time_string = ""
  if hours > 24
    sum_time_string = "#{(hours / 24).to_i} day & " 
    hours %= 24
  end
  sum_time_string += "#{zerofill(hours)}:#{zerofill(minutes)}:#{zerofill(seconds)}"
end

puts "Enter the first time value"
first_time = gets.chomp
puts "Enter the second time value"
second_time = gets.chomp
regex_for_time = /^(([01]?\d)|(2[0-3]))([:]([0-5]?\d)){2}$/
#check for valid time
unless first_time.match(regex_for_time) && second_time.match(regex_for_time)
  puts "Invalid time entered"
else
  puts "Sum of times = #{sum_time(Time.parse(first_time), Time.parse(second_time))}"
end
