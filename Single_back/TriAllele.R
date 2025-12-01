A = readLines("multiallele.recode.vcf")
f = grep("#CHROM", A)
A = A[(f + 1):length(A) ]


x = as.numeric(unname(sapply(A, function(x) strsplit(x, "\t")[[1]][2] )))

plot(x, rep(1, length(x)))