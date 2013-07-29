puts "please enter some text: "
string = gets
string = string.gsub(/[aeiou]/i, '*')
puts string
