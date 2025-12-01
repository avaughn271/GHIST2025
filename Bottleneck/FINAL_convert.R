A = readLines("Final.recode.vcf")
head(A)
linee = grep("CHROM", A)
if (length(linee)  != 1) {print("PROBLEM")}

A = A[(linee +1):length(A)]

nonbiallelic = union(grep("\\|2", A), grep("2\\|", A))

A = A[-nonbiallelic]

f = function(x) {
  temp = strsplit(x,"\t")[[1]]
  stringg1 = "1" 
  return(as.numeric(temp[2]))
}

g = function(x) {
  temp = strsplit(x,"\t")[[1]]
  stringg1 = "1" 
  stringg2 = temp[2]
  temp = paste0(temp[-c(1,2,3,4,5,6,7,8,9)])
  tempstring = ""
  for (i in temp) {
    if (i == "0|0") {
      tempstring = paste0(tempstring, "AA")
    }
    if (i == "1|1") {
      tempstring = paste0(tempstring, "GG")
    }
    if (i == "1|0") {
      tempstring = paste0(tempstring, "GA")
    }
    if (i == "0|1") {
      tempstring = paste0(tempstring, "AG")
    }
  }
  return(tempstring)
  
}

bases = unname(sapply(A, f))
chromess = rep("1", length(bases))
gaps = c(1, bases[-1] - bases[-length(bases)])
snps = unname(sapply(A, g))
write.table(data.frame(chromess, bases, gaps, snps),   "OutputFinalSHORT.txt", 
            sep = "\t", quote = F, row.names = F, col.names= F)
