A = read.table("temp.txt")
R = c()
Amax = rep(-1, nrow(A))
for (i in 1:nrow(A) ) {
  guess = rep(-1, nrow(A))
  for (j in 1:nrow(A)) {
    f1 = A[i,1] / A[i,2]
    f2 = A[j,1] / A[j,2]
    
    g1 = A[i,3]
    g2 = A[j,3]
    rrmse = sqrt(  ((f1-f2)/f1  )**2    +   ( (g1-g2)/g1  )**2  )
    if (rrmse > 0.125) break
 # R = c(R, rrmse)
  guess[j] =  rrmse
  }
  Amax[i] = max(guess)
  print(max(guess))
  if ( Amax[i] < 0.125 &Amax[i] > 0 ) print(A[i,])
}

0.519

plot(Amax)
A[which(Amax < 0.142),]


quantile(A[[1]]/A[[2]])

quantile(A[[3]])




######26500 93500 3360


