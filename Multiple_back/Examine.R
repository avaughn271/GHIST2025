A  = readLines("output.frq")[-1]
c = rep(0, length(A))
Position = rep(0, length(A))
for (i in 1:length(A)) {
  l = strsplit(A[i], ":")[[1]]
   c[i] = as.numeric(l[length(l)])
   
   chromm = strsplit(A[i], "\t")[[1]]
   Position[i] = as.numeric(chromm[2])
   
}
A  = 79300000
B = 79550000
plot(Position, c, xlim = c(7.9e7, 8e7))
lines(c(A,A) , c(-1000,1000))
lines(c(B,B) , c(-1000,1000))
a  = 48000000
b = 48420000
plot(Position, c, xlim = c(4.78e7, 4.88e7))
lines(c(a,a) , c(-1000,1000))
lines(c(b,b) , c(-1000,1000))
 B- A + b - a
 b-a
 B-A
