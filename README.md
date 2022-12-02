# Reverse-Bayes Methods for Replication Studies and Beyond

This repository contains all files for reproducing the PhD thesis from Samuel
Pawel. A heavily modified version of the LaTeX thesis template from Sebastian
Meyer (GPL2 license) is used. My template contains some ugly hacks, so use at
your own risk!

## Reproducing the individual papers
The thesis contains six papers, `.tex` and figure output files for each of them
are already included in the repository. Code and data to reproduce them
individually can be found at

1) The assessment of replication success based on relative effect size:
<https://github.com/SamCH93/RSgolden/>

2) The sceptical Bayes factor for the assessment of replication success:
<https://gitlab.uzh.ch/samuel.pawel/BFScode>

3) Bayesian approaches to designing replication studies: 
<https://github.com/SamCH93/BAtDRS> 

4) Reverse-Bayes methods for evidence assessment and research synthesis
<https://gitlab.uzh.ch/samuel.pawel/Reverse-Bayes-Code>

5) Comment on "Bayesian additional evidence for decision making under small
sample uncertainty": <https://github.com/SamCH93/BAEcomment>

6) Pitfalls and Potentials in Simulation Studies:
<https://github.com/SamCH93/SimPaper>


## 1. Reproducing the thesis locally
Make sure that LaTeX (e.g., texlive-full on Ubuntu), R, and the following R
packages are installed

```r
pkgs <- c("knitr", "ggplot2", "xtable", "ReplicationSuccess", "dplyr", "UpSetR")
install.packages(pkgs)
```

Then run

```sh
make
```

this should produce `thesis.pdf`. The following R and R package versions were
used when last successfully tested

```r
sessionInfo()
#> R version 4.2.2 Patched (2022-11-10 r83330)
#> Platform: x86_64-pc-linux-gnu (64-bit)
#> Running under: Ubuntu 20.04.5 LTS
#> 
#> Matrix products: default
#> BLAS:   /usr/lib/x86_64-linux-gnu/blas/libblas.so.3.9.0
#> LAPACK: /usr/lib/x86_64-linux-gnu/lapack/liblapack.so.3.9.0
#> 
#> locale:
#>  [1] LC_CTYPE=en_US.UTF-8       LC_NUMERIC=C              
#>  [3] LC_TIME=de_CH.UTF-8        LC_COLLATE=en_US.UTF-8    
#>  [5] LC_MONETARY=de_CH.UTF-8    LC_MESSAGES=en_US.UTF-8   
#>  [7] LC_PAPER=de_CH.UTF-8       LC_NAME=C                 
#>  [9] LC_ADDRESS=C               LC_TELEPHONE=C            
#> [11] LC_MEASUREMENT=de_CH.UTF-8 LC_IDENTIFICATION=C       
#> 
#> attached base packages:
#> [1] stats     graphics  grDevices utils     datasets  methods   base     
#> 
#> other attached packages:
#> [1] UpSetR_1.4.0           dplyr_1.0.10           ReplicationSuccess_1.2
#> [4] xtable_1.8-4           ggplot2_3.4.0          knitr_1.40            
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.9       magrittr_2.0.3   tidyselect_1.2.0 munsell_0.5.0   
#>  [5] colorspace_2.0-3 R6_2.5.1         rlang_1.0.6      fansi_1.0.3     
#>  [9] stringr_1.4.1    plyr_1.8.7       tools_4.2.2      grid_4.2.2      
#> [13] gtable_0.3.1     xfun_0.34        utf8_1.2.2       cli_3.4.1       
#> [17] DBI_1.1.3        withr_2.5.0      digest_0.6.30    assertthat_0.2.1
#> [21] tibble_3.1.8     lifecycle_1.0.3  gridExtra_2.3    vctrs_0.5.0     
#> [25] glue_1.6.2       stringi_1.7.8    compiler_4.2.2   pillar_1.8.1    
#> [29] generics_0.1.3   scales_1.2.1     pkgconfig_2.0.3 
```


## 2. Reproducing the thesis within a Docker container

TODO: implement Docker support
