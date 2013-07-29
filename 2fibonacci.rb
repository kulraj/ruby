def fibonacci
  before_previous = 0
  previous = 1
  printf("0 1 ")#first two numbers in sequence
  while
    current = before_previous + previous
    yield 1000, current
    before_previous = previous
    previous = current
  end
end

fibonacci do |limit, current|
  exit if current > limit
  printf("%d ",current)
end
