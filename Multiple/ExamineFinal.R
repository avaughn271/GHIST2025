A  = readLines("ouyputFinal.frq")[-1]
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
plot(Position, c, xlim = c(xlim = c(9.3e7, 9.5e7)))
plot(Position, c, xlim = c(xlim = c(9.43e7, 9.46e7)))


lines(c(9.445e7,9.445e7) , c(-1000,1000))
lines(c(9.457e7,9.457e7) , c(-1000,1000))
lines(c(3.545e7,3.545e7) , c(-1000,1000), col = "red")


indicess = which(c < 0.9 & c > 0.04 )

points(Position[indicess], c[indicess], col = "blue")

max(Position[indicess][-1] - Position[indicess][-length(indicess)])


