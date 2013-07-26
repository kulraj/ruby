def fibonacci
  printf("0 ")
  yield 1000, 0, 1, 1
  puts "\n";
end

fibonacci do |limit, a, b, c|
  begin
    printf("%d ",c)
    c = a + b
    a = b
    b = c
  end while c < limit
end
