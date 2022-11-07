install.packages("tidyverse")
install.packages("Seurat")

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("genefilter","ballgown","edgeR","GenomicRanges","rhdf5","biomaRt","scran","sva","gage","org.Hs.eg.db"))