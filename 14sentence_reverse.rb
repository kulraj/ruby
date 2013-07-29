<<-doc
Use string methods to reverse the words arrangement in a sentence.
Eg: "An apple a day keeps the doctor away" -> "away doctor the keeps day a apple An"
doc

string = gets.chomp
puts string.split(" ").reverse.join(" ")
