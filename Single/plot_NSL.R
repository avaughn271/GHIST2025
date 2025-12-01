A = read.table("Final.nsl.out")

 
plot(A[[2]], abs(A[[6]]) )

plot(A[[2]], abs(A[[6]]), xlim = c(3.2e7,3.8e7  ))

#plot(density(A[[2]], width = 1000), xlim = c(2.84e7,2.94e7) )
distances =   A[[2]][-1] - A[[2]][-length(A[[2]])] 
max(distances)
indexx = which(distances == max(distances))
A[[2]][(indexx-2):(indexx+2)]
plot( A[[2]][-1],    A[[2]][-1] - A[[2]][-length(A[[2]])] , xlim = c(2.84e7,2.94e7)  )

#guess 3 was simply biggest gap in between snps.
A[[2]][(indexx-2):(indexx+2)] # this was used to get guess 4