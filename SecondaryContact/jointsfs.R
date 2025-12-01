FILE = readLines("biTest.recode.vcf")
MATRIX = matrix(0, nrow = 2*24 + 1 , ncol = 2*11 + 1)

for (snpline in 10:length(FILE)) {
SNP = strsplit(FILE[snpline], "\t")[[1]]
Mainland = c()
for (i in 10:33) {
  Mainland = c(Mainland, as.numeric(strsplit(SNP[i], "")[[1]][1]) )
  Mainland = c(Mainland, as.numeric(strsplit(SNP[i], "")[[1]][3]) )
}
mainlandsum = sum(Mainland)
Island = c()
for (i in 34:44) {
  Island = c(Island, as.numeric(strsplit(SNP[i], "")[[1]][1]) )
  Island = c(Island, as.numeric(strsplit(SNP[i], "")[[1]][3]) )
}
islandsum = sum(Island)
MATRIX[mainlandsum + 1, islandsum + 1] = MATRIX[mainlandsum + 1, islandsum + 1] + 1
if (mainlandsum == 48 & islandsum == 22) {print(snpline)}
}
MATRIX[1,1] = 100000000 - sum(MATRIX)

write.table(MATRIX, "Test.csv", row.names = F, col.names = F, quote= F)
