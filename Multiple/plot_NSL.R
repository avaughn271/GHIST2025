A = read.table("testing.nsl.out")

 
plot(A[[2]], abs(A[[6]]) )

byyy =  1e7/4
index  = 1 
for (i in seq(min(A[[2]]), max(A[[2]]) - byyy, by = byyy)) {
  plot(A[[2]], abs(A[[6]]) , xlim = c(i, i+ 1.5*byyy), main = index)
  index = index + 1
} 

