install.packages(c("devtools", "tidyverse"))
install.packages(c("Seurat", "SeuratObject"))

if (!requireNamespace("BiocManager", quietly = TRUE))
    install.packages("BiocManager")
BiocManager::install(c("genefilter","ballgown","edgeR","GenomicRanges","rhdf5","biomaRt","scran","sva","gage","org.Hs.eg.db"))