<<-doc
Print Pascal's triangle using 'yield'.
Eg: pascal(6) gives:
1
1 1
1 2 1
1 3 3 1
1 4 6 4 1
1 5 10 10 5 1
1 6 15 20 15 6 1
doc


def pascal_triangle
  printf("enter n: ")
  n = gets.to_i
  0.upto(n) do |n|
    0.upto(n) do |k|
      yield n,k
    end
    printf("\n")
  end
end

#calculate factorial by inject
def factorial(n)
  (1..n).inject(1) {|product, i| product * i}
end

# print combination C(n,k)
pascal_triangle do |n, k|
  printf("%d ", factorial(n) / (factorial(k) * factorial(n - k)))
end
