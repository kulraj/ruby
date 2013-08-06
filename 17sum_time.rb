<<-doc
Write a method that sums up 2 24-hour time values(h:m:s). Validate the time using regular expressions.
Eg: ("0:45:34","0:15:58") -> 01:01:32 ; ("11:23:07","22:53:45") -> 1 day & 10:16:52
doc

require "time"

def to_seconds(timestamp)
  3600 * timestamp.hour + 60 * timestamp.min + timestamp.sec
end

def sum_time(first_timestamp, second_timestamp)
first_time_seconds = to_seconds(first_timestamp)
second_time_seconds = to_seconds(second_timestamp)
total_seconds = first_time_seconds + second_time_seconds
sum_time_string = ""
sum_time_string = "1 day & " if total_seconds > 24 * 3600
sum_time_string += Time.at(total_seconds).utc.strftime("%I:%M:%S")
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
