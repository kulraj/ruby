def fibonacci
  printf("0 1 ")
  yield 1000, 0, 1
  puts "\n";
end

fibonacci do |limit, a, b|
  begin
    c = a + b
    printf("%d ",c)
    a = b
    b = c
  end while c < limit
end
