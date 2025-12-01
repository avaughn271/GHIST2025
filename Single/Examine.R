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
plot(Position, c, xlim = c(2.5e7, 3.2e7))

plot(Position, c, xlim = c(2.8e7, 2.97e7))
plot(Position, c, xlim = c(2.85e7, 2.9e7))
lines(c(28725920,28725920) , c(-1000,1000))
lines(c(28729600,28729600) , c(-1000,1000))
lines(c(28790920,28790920) , c(-1000,1000), col = "red")
lines(c(28590000,28590000) , c(-1000,1000), col = "red")


indicess = which(c < 0.96 & c > 0.04 )
points(Position[indicess], c[indicess], col = "blue")

max(Position[indicess][-1] - Position[indicess][-length(indicess)])


