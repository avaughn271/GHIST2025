A = read.table("Final.nsl.out")

 
plot(A[[2]], abs(A[[6]]) )
for (i in seq(2e7, 9e7, by = 1e7/2)) {
  plot(A[[2]], abs(A[[6]]) , xlim = c(i, i+1e7))
} 



plot(A[[2]], abs(A[[6]]) , xlim = c(2e7, 2.2e7))
plot(A[[2]], abs(A[[6]]) , xlim = c(9.3e7, 9.5e7))
