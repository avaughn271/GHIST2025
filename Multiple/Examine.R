A  = readLines("output.frq")[-1]
c = rep(0, length(A))
Position = rep(0, length(A))
for (i in 1:length(A)) {
  l = strsplit(A[i], ":")[[1]]
   c[i] = as.numeric(l[length(l)])
   
   chromm = strsplit(A[i], "\t")[[1]]
   Position[i] = as.numeric(chromm[2])
   
}

byyy =  1e7/4
index  = 1 

A = read.table("testing.nsl.out")

for (i in seq(min(A[[2]]), max(A[[2]]) - byyy, by = byyy)) {
if (index %in%  c(6,20,21,28)   )  {
  plot( Position, c , xlim = c(i, i+ 1.5*byyy), main = index)

 pos = 3.5e7

lines(c(pos - 1e6/8, pos - 1e6/8 ) , c(-100,1000)   )
lines(c(pos , pos ) , c(-100,1000)   )


lines(c(4.2e7, 4.2e7 ) , c(-100,1000)   )
lines(c(4.55e7 , 4.55e7 ) , c(-100,1000)   )

lines(c(6.922e7, 6.922e7 ) , c(-100,1000)   )
lines(c(6.935e7 , 6.935e7 ) , c(-100,1000)   )

lines(c(7.225e7, 7.225e7 ) , c(-100,1000)   )
lines(c(7.265e7 , 7.265e7 ) , c(-100,1000)   )

lines(c(8.95e7, 8.95e7 ) , c(-100,1000)   )
lines(c(8.99e7 , 8.99e7 ) , c(-100,1000)   )

}
  index = index + 1
} 

8.99e7 - 8.95e7    + 7.265e7 - 7.225e7 + 6.935e7 - 6.922e7 - 43350000 + 43580000 +  3.5e7  - ( 3.5e7 - 1e6/8 )


 3.5e7  - ( 3.5e7 - 1e6/8 )
43580000 - 43350000

 6.935e7 - 6.922e7 

 7.265e7 - 7.225e7
8.99e7 - 8.95e7




  plot( Position, c , xlim = c(4.2e7, 4.55e7), main =  "supp")
lines(c(43350000, 43350000  )   , c(-100,1000)    )   
lines(c(43580000, 43580000  )   , c(-100,1000)    ) 
