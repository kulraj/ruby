<<-doc
Write a method that sums up 2 24-hour time values(h:m:s). Validate the time using regular expressions.
Eg: ("0:45:34","0:15:58") -> 01:01:32 ; ("11:23:07","22:53:45") -> 1 day & 10:16:52
doc

require "time"

def to_seconds(time)
  timestamp = Time.parse(time)
  3600 * timestamp.hour + 60 * timestamp.min + timestamp.sec
end

def sum_time(first_time, second_time)
  total_seconds = to_seconds(first_time) + to_seconds(second_time)
  sum_time_string = ""
  sum_time_string = "1 day & " if total_seconds > 24 * 3600
  sum_time_string += Time.at(total_seconds).utc.strftime("%H:%M:%S")
end

def validate_time(time)
  time.match(/^(([01]?\d)|(2[0-3]))([:]([0-5]?\d)){2}$/)
end

puts "Enter the first time value"
first_time = gets.chomp
puts "Enter the second time value"
second_time = gets.chomp

#check for valid time
if validate_time(first_time) && validate_time(second_time)
  puts "Sum of times = #{sum_time(first_time, second_time)}"
else
  puts "Invalid time entered"
end
