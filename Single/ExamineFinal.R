A  = readLines("output_Final.frq")[-1]
c = rep(0, length(A))
Position = rep(0, length(A))
for (i in 1:length(A)) {
  l = strsplit(A[i], ":")[[1]]
   c[i] = as.numeric(l[length(l)])
   
   chromm = strsplit(A[i], "\t")[[1]]
   Position[i] = as.numeric(chromm[2])
   
}

max(Position[-1] - Position[-length(Position)])
#plot(Position, c)
#plot(Position, c, xlim = c(xlim = c(3.2e7,3.8e7  )))
plot(Position, c, xlim = c(xlim = c(3.5e7,3.57e7  )))


lines(c(3.5305e7,3.5305e7) , c(-1000,1000), col = "blue")
lines(c(3.5575e7,3.5575e7) , c(-1000,1000), col = "blue")
lines(c(3.545e7,3.545e7) , c(-1000,1000), col = "red")
(3.5575e7 - 3.5305e7)/1e5

#indicess = which(c < 0.9 & c > 0.04 )

#points(Position[indicess], c[indicess], col = "blue")

#max(Position[indicess][-1] - Position[indicess][-length(indicess)])


