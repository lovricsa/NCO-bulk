## Requirements & Dependencies

This project was developed under the following environment:
* **R Version:** 4.6.1
* **OS:** Ubuntu 24.04.4 LTS (x86_64-pc-linux-gnu)

## Setup R packages

Run the following R snippet to automatically check for and install any missing packages required by this project (handles CRAN and Bioconductor dependencies):

```r
# List of required packages
required_packages <- c(
  "tidyverse",            # Includes ggplot2, dplyr, tidyr, readr, purrr, forcats, tibble
  "limma",                # Differential expression analysis
  "edgeR",                # Normalization and DGEList
  "SummarizedExperiment", # Reading SummarizedExperiment assay data
  "ComplexHeatmap",       # Heatmap plotting & annotations
  "openxlsx",             # Writing Excel files
  "here",                 # Relative path management
  "AnnotationDbi",        # Database mapping
  "org.Hs.eg.db",         # Human gene annotation database
  "rtracklayer"           # Importing GTF annotation files
)

# Ensure BiocManager is installed
if (!requireNamespace("BiocManager", quietly = TRUE)) {
  install.packages("BiocManager")
}

# Identify missing packages
missing_packages <- required_packages[!(required_packages %in% installed.packages()[, "Package"])]

# Install missing packages
if (length(missing_packages) > 0) {
  message("Installing missing packages: ", paste(missing_packages, collapse = ", "))
  BiocManager::install(missing_packages, ask = FALSE)
} else {
  message("All required packages are already installed!")
}
```

> **Note on GitHub-only packages:** If any package fails to install via `BiocManager`, install `remotes` via `install.packages("remotes")` and install directly from their respective GitHub repositories.

---

<details>
<summary><b>Click to view full R sessionInfo()</b></summary>

```text
R version 4.6.1 (2026-06-24)
Platform: x86_64-pc-linux-gnu
Running under: Ubuntu 24.04.4 LTS

Matrix products: default
BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.12.0 
LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.12.0  LAPACK version 3.12.0

locale:
 [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C               LC_TIME=hu_HU.UTF-8        LC_COLLATE=en_US.UTF-8     LC_MONETARY=hu_HU.UTF-8    LC_MESSAGES=en_US.UTF-8    LC_PAPER=hu_HU.UTF-8      
 [8] LC_NAME=C                  LC_ADDRESS=C               LC_TELEPHONE=C             LC_MEASUREMENT=hu_HU.UTF-8 LC_IDENTIFICATION=C       

time zone: Europe/Budapest
tzcode source: system (glibc)

attached base packages:
[1] stats4    grid      stats     graphics  grDevices utils     datasets  methods   base     

other attached packages:
 [1] org.Hs.eg.db_3.23.1         AnnotationDbi_1.74.0        htmltools_0.5.9             htmlwidgets_1.6.4           DT_0.34.0                   clusterProfiler_4.20.0     
 [7] msigdbr_26.1.1              biomaRt_2.68.0              here_1.0.2                  lubridate_1.9.5             forcats_1.0.1               stringr_1.6.0              
[13] purrr_1.2.2                 tibble_3.3.1                tidyverse_2.0.0             DESeq2_1.52.0               SummarizedExperiment_1.42.0 Biobase_2.72.0             
[19] MatrixGenerics_1.24.0       matrixStats_1.5.0           GenomicRanges_1.64.0        Seqinfo_1.2.0               IRanges_2.46.0              S4Vectors_0.50.3           
[25] BiocGenerics_0.58.1         generics_0.1.4              patchwork_1.3.2             uwot_0.2.5                  Matrix_1.7-4                ggrepel_0.9.8              
[31] ggmagnify_0.4.2             readxl_1.5.0.1              openxlsx_4.2.9              readr_2.2.0                 ComplexUpset_1.3.3          UpSetR_1.4.1               
[37] tidyr_1.3.2                 dplyr_1.2.1                 edgeR_4.10.5                limma_3.68.5                circlize_0.4.18             tidyHeatmap_1.13.1         
[43] ComplexHeatmap_2.28.0       ggplot2_4.0.3             
```

</details>

## Bulk Differential Expression Analysis

### Description
Reproduces the bulk RNA-seq analysis 

### Required Input Files
- `Data/GSE335741_salmon.merged.gene_counts.tsv`: Organoid gene-level counts (provided)
- `Data/GSE335741_salmon.merged.gene_tpm.tsv`: Organoid gene-level TPM values (provided).
- `Data/samplesheet.csv`: Organoid sample sheet (provided).
- `Gencode/gencode.v49.primary_assembly.annotation.gtf`: GENCODE v49 annotation. Download from Gencode.
- `Data_GSE147635/star_salmon/null.merged.gene.SummarizedExperiment.rds` and `Data_GSE94035/star_salmon/null.merged.gene.SummarizedExperiment.rds`: nf-core (STAR/Salmon) gene-level `SummarizedExperiment` objects obtained from the public datasets (provided).
- `Public_data/SraRunTable_GSE147635.csv` and `Public_data/SraRunTable_GSE94035.csv`: SRA run tables with sample annotation (provided).
- `Data_GDC/gdc_sample_sheet.<date>.tsv` and the corresponding STAR gene-count files downloaded from the GDC portal (TARGET-NBL), located in subfolders of `Data_GDC/`. Download from the GDC portal.

MSigDB gene sets are retrieved through the `msigdbr` package and need no input file.

### Notes
- Directories `Data_calculated/`, `Figures/` and `Results/` are created automatically if they do not exist.
