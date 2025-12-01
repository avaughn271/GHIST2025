A = readLines("GHIST_2025_singlesweep.21.testing.vcf")

A = A[7:length(A)]
numsnps = length(A)
numberofindivs = length(strsplit(A[1] ,"\t")[[1]]) - 9
numberofhaps = 2*numberofindivs
MATRIX  = matrix(0, nrow = numsnps, ncol = numberofhaps)

for (i in 1:numsnps) {
   temp = strsplit(A[i] ,"\t")[[1]][-c(1,2,3,4,5,6,7,8,9)]
  indexx = 1
  for (j in 1:numberofindivs) {
    MATRIX[i,indexx] = as.numeric(substr(temp[j], 1, 1))
    indexx = indexx + 1
    MATRIX[i,indexx ] = as.numeric(substr(temp[j], 3, 3))
    indexx = indexx + 1
  }
}

L_ij_LIST = list()
print(numsnps)

nA = rep(0, numsnps)
nD = rep(0, numsnps)
L_D = rep(0, numsnps)
L_A = rep(0, numsnps)

for (k in 1:numsnps) {

  nD[k] = sum(MATRIX[k,])
  nA[k] = numberofhaps - nD[k]
  
  
  
  print(k)
  L_ijmatrix = matrix(0, nrow = numberofhaps, ncol  = numberofhaps)
  
  for (i in 1:(numberofhaps - 1) ) {
    for (j in (i+1):(numberofhaps) ) {
      summ = 0
      LEFT = k
      RIGHT = k
      while (LEFT > 1 && (MATRIX[LEFT - 1, i] == MATRIX[LEFT - 1, j])) {
        LEFT = LEFT - 1
      }
      while (RIGHT < numsnps && (MATRIX[RIGHT + 1, i] == MATRIX[RIGHT + 1, j])) {
        RIGHT = RIGHT + 1
      }
      L_ijmatrix[i,j] = RIGHT - LEFT + 1
  }
  }
  
  for (i in 1:(numberofhaps - 1) ) {
    for (j in (i+1):(numberofhaps) ) {
      if (MATRIX[k,i] + MATRIX[k,j] == 2) {
        L_D[k]  = L_D[k] + L_ijmatrix[i,j] 
      }
      if (MATRIX[k,i] + MATRIX[k,j] == 0) {
        L_A[k]  = L_A[k] + L_ijmatrix[i,j] 
      }
    }
  }
  
}
write.table(data.frame(nA, nD, L_A, L_D), "output.txt", row.names = F)
