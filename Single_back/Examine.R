A  = readLines("output.frq")[-1]
c = rep(0, length(A))
Position = rep(0, length(A))
for (i in 1:length(A)) {
  l = strsplit(A[i], ":")[[1]]
   c[i] = as.numeric(l[length(l)])
   
   chromm = strsplit(A[i], "\t")[[1]]
   Position[i] = as.numeric(chromm[2])
   
}

max(Position[-1] - Position[-length(Position)])
plot(Position, c)
plot(Position, c, xlim = c(4.3e7, 4.5e7))
lines(c(4.335e7,4.335e7) , c(-1000,1000))
lines(c(4.38e7,4.38e7) , c(-1000,1000))

plot(Position, c, xlim = c(4.31e7, 4.39e7))
lines(c(43425000,43425000) , c(-1000,1000))
lines(c(43350000,43350000) , c(-1000,1000))
 