A = read.table("output.txt", header = T)

nrow(A)
sum(A[[1]] > 1 & A[[2]] > 1)
VECTOR = rep(-100000, nrow(A))
for (i in 1:nrow(A)) {
  if (A[[1]][i] > 1  & A[[2]][i] > 1) {
    hd = 2* A[i,4]/(A[i,2] * (A[i,2] - 1) )
    ha = 2* A[i,3]/(A[i,1] * (A[i,1] - 1) )
    VECTOR[i] =  log(hd/ha)
  }
    
}
 
VECTOR = VECTOR[which(VECTOR > -100000)]

plot (   (VECTOR - mean(VECTOR))/(var(VECTOR)**0.5)  )