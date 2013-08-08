<<-doc
Implement a reverse iteration function for Array such that I should be able to do this
[2,4,6,8].reverse_iterate { i print i }
It would print 8 6 4 2
Do not use any existing iterator for this.
doc

class Array
  def reverse_iterate
    i = length
    while i > 0
      i -= 1
      yield self[i]
    end      
  end
end

array = [2,4,6,8]
array.reverse_iterate { |i| print "#{i} "}
