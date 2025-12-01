A = read.table("testing.nsl.out")

 
plot(A[[2]], abs(A[[6]]) )

plot(A[[2]], abs(A[[6]]) , xlim = c(2e7, 3.5e7))

plot(A[[2]], abs(A[[6]]) , xlim = c(4.2e7, 4.6e7))
