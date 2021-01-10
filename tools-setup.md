
#Install using conda

conda create -n rna-seq r-essentials r-base python=3.7

conda config --add channels conda-forge

conda config --add channels defaults

conda config --add channels r

conda config --add channels bioconda

conda install -c bioconda hisat2

conda install -c bioconda samtools

conda install -c bioconda stringtie

conda install -c bioconda gffcompare


conda install -c bioconda bioconductor-biocinstaller 

conda install -c conda-forge r-gert 

conda install -c conda-forge r-devtools / conda install -c r r-devtools

conda install bioconductor-ballgown

conda install -c r r-dplyr

conda install bioconductor-genefilter

#Install using R

devtools::install_github("alyssafrazee/RSkittleBrewer")

install.packages(‘BiocManager’)

BiocManager::install(‘ballgown’)

BiocManager::install(‘cowplot’)

