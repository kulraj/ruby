<<-doc
Modify the sum of times method for any number of time values passed to this method.
Eg: ("11:23:07","22:53:45","0:23:23","23:45:56") -> "2 day & 10:26:11"
("0:45:34","0:15:58") -> 01:01:32 ; ("11:23:07","22:53:45") -> 1 day & 10:16:52
doc

def sum_time(*time)
  # initialize the variables
  time_array = []
  0.upto(time.length - 1) do |i|
    time_array[i] = time[i].split(":")
  end
  carry = 0
  sum = []
  sum_string = ""
  # start loop, first add seconds then minutes then hours
  2.downto(0) do |i|
    sum[i] = carry
    0.upto(time.length - 1) do |j|
      sum[i] += time_array[j][i].to_i
    end
    if i == 0 # hours
      days = sum[i] / 24
      sum[i] %= 24
      sum_string = days.to_s + " day & "
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

puts sum_time("11:23:07","22:53:45","0:23:23","23:45:56")
