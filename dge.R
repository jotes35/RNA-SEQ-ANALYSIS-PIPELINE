
#load libraries

library(devtools)
library(ballgown)
library(genefilter)
library(dplyr)
library(RSkittleBrewer)


#phenotype data
pheno_data <-  read.csv("chrX_data/geuvadis_phenodata.csv")

# show information for first 6 samples
head(pheno_data)

#load expression data using ballgown
bg_chrX <- ballgown(dataDir = 'abundance', samplePattern = 'ERR', pData=pheno_data)

#check some information about the loaded abundances 
class(bg_chrX)


#get gene expression levels
head(gexpr(bg_chrX), 3)


#get transcript expression levels
head(texpr(bg_chrX),3)

#filter out remove genes/transcripts with low variance
bg_chrX_filt=subset(bg_chrX,"rowVars(texpr(bg_chrX)) >1",genomesubset=TRUE)

#perform differential expression analysis on transcripts
results_transcripts <- stattest(bg_chrX_filt, feature="transcript",covariate="sex", adjustvars =c("population"), getFC=TRUE, meas="FPKM")

#check the first 6 transcripts and their values
head(results_transcripts)

#check how many of the transcripts have qvalue <0.05 we use the command
table(results_transcripts$qval < 0.05)


#perform differential expression analysis on genes
results_genes <- stattest(bg_chrX_filt, feature="gene",covariate="sex", adjustvars =c("population"), getFC=TRUE, meas="FPKM")

#check the first 6 genes
head(results_genes)


#find out how many of the genes have a qvalue < 0.05
table(results_genes$qval<0.05)


#add geneIDs to transcript result.
results_transcripts = data.frame(geneNames=ballgown::geneNames(bg_chrX_filt), geneIDs=ballgown::geneIDs(bg_chrX_filt), results_transcripts)


#check if information was added
head(results_transcripts)



#Lets arrange the results from the smallest P value to the largest

results_transcripts = arrange(results_transcripts,pval)
head(results_transcripts)

results_genes = arrange(results_genes,pval)
head(results_genes)

#We can now save the results to a file (csv recommended)
write.csv(results_transcripts, "fc_transcript_results.csv", row.names=FALSE)
write.csv(results_genes, "fc_gene_results.csv", row.names=FALSE)

subset_transcripts <- subset(results_transcripts,results_transcripts$qval<0.05)
subset_genes <- subset(results_genes,results_genes$qval<0.05)
 

#Save to file
write.csv(subset_transcripts, "fc_transcript_subset.csv", row.names=FALSE)
write.csv(subset_genes, "fc_gene_subset.csv", row.names=FALSE)
