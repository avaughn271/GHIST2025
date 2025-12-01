
 vcftools --vcf  *testing.vcf --max-alleles 2 --min-alleles 2 --out biallele --recode

./selscan-main/bin/macos-arm64/selscan --nsl --vcf biallele.recode.vcf  --out testing --keep-low-freq 


Rscript plot_NSL.R

 vcftools --vcf biallele.recode.vcf --freq 	--out output





e SNPs. TriAlelle.R can be used to examine. Lack of tripletons is where sweep is.
2)   vcftools --vcf biallele.recode.vcf --freq 	--out output
3) Examine.R or ExamineFinal.R can then be used to choose the best position based on regions with only snps >96% or less than 4%



./selscan-main/bin/macos-arm64/selscan --nsl --vcf biallele_Final.recode.vcf --out Final --keep-low-freq 








94450000 to 94570000  seems pretty good for a location!! but could check with NSL!!!
Remeber to change chromosomes!!!!
