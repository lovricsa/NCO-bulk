#!/usr/bin/env bash
set -e

Rscript -e 'install.packages("BiocManager", repos = "https://cloud.r-project.org")'

# Bioconductor (the release is chosen automatically to match the R version)
Rscript -e 'BiocManager::install(c(
  "limma", "edgeR", "DESeq2", "SummarizedExperiment", "ComplexHeatmap",
  "biomaRt", "clusterProfiler", "enrichplot", "org.Hs.eg.db",
  "AnnotationDbi", "rtracklayer"
), ask = FALSE, update = FALSE)'

# CRAN
Rscript -e 'install.packages(c(
  "tidyverse", "here", "openxlsx", "readxl", "circlize", "UpSetR",
  "ComplexUpset", "ggrepel", "uwot", "patchwork", "DT", "htmlwidgets",
  "htmltools", "msigdbr", "tidyHeatmap", "ggmagnify", "rmarkdown", "knitr"
), repos = "https://cloud.r-project.org")'
