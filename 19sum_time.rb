<<-doc
Modify the sum of times method for any number of time values passed to this method.
Eg: ("11:23:07","22:53:45","0:23:23","23:45:56") -> "2 day & 10:26:11"
("0:45:34","0:15:58") -> 01:01:32 ; ("11:23:07","22:53:45") -> 1 day & 10:16:52
doc

require 'time'

def to_seconds(timestamp)
  timestamp.hour * 3600 + timestamp.min * 60 + timestamp.sec
end

def sum_time(*time)
  # initialize the variables
  total_seconds = 0
  time.each do |time_item|
    timestamp = Time.parse(time_item)
    total_seconds += to_seconds(timestamp)
  end
  sum_time_string = ""
  days = (total_seconds / (24 * 3600)).to_i
  sum_time_string = "#{days} day & " if days > 0
  sum_time_string += Time.at(total_seconds).utc.strftime("%H:%M:%S")
end

puts sum_time("11:23:07","22:53:45","0:23:23","23:45:56")
