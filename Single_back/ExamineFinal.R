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
 plot(Position, c, xlim = c(xlim = c(9.3e7, 9.5e7)))
plot(Position, c, xlim = c(xlim = c(9.43e7, 9.46e7)))

xlef = 9.444e7
xright = 9.457e7

lines(c(xlef,xlef) , c(-1000,1000) , col = "blue")
lines(c(xright,xright) , c(-1000,1000), col = "blue")
lines(c( (xright+xlef ) / 2 , (xright+xlef ) / 2) , c(-1000,1000), col = "red")
 

(xright - xlef)/(1e5)

