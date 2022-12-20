# Reverse-Bayes Methods for Replication Studies

This repository contains all files for reproducing the PhD thesis from Samuel
Pawel. The thesis is based on a heavily modified version of the LaTeX thesis
template from Sebastian Meyer (GPL2 license). My template contains some ugly
hacks, use it at your own risk!


## 1. Reproducing the thesis locally

Make sure that LaTeX (e.g., texlive-full on Ubuntu), R, and the R packages in
`CRANpackages.txt` are installed

```sh
## install packages from CRAN by running from a shell
R -e 'install.packages(read.delim("CRANpackages.txt", header = FALSE)[,1])'
```

Then run 

```
make local
```

this should produce `thesis.pdf`. 


Although the analyses depend on only few dependencies, this approach may lead to
different results (or not even compile successfully) in the future if R or the
packages change. The R and R package versions which were used when the thesis
was successfully compiled the last time are visible in the following output

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
#> [4] xtable_1.8-4           scales_1.2.1           ggpubr_0.4.0          
#> [7] ggplot2_3.4.0          knitr_1.40            
#> 
#> loaded via a namespace (and not attached):
#>  [1] Rcpp_1.0.9       highr_0.9        plyr_1.8.7       pillar_1.8.1    
#>  [5] compiler_4.2.2   tools_4.2.2      evaluate_0.18    lifecycle_1.0.3 
#>  [9] tibble_3.1.8     gtable_0.3.1     pkgconfig_2.0.3  rlang_1.0.6     
#> [13] DBI_1.1.3        cli_3.4.1        xfun_0.34        gridExtra_2.3   
#> [17] stringr_1.4.1    withr_2.5.0      generics_0.1.3   vctrs_0.5.0     
#> [21] cowplot_1.1.1    grid_4.2.2       tidyselect_1.2.0 glue_1.6.2      
#> [25] R6_2.5.1         rstatix_0.7.1    fansi_1.0.3      carData_3.0-5   
#> [29] farver_2.1.1     purrr_0.3.5      tidyr_1.2.1      car_3.1-1       
#> [33] magrittr_2.0.3   backports_1.4.1  assertthat_0.2.1 abind_1.4-5     
#> [37] colorspace_2.0-3 ggsignif_0.6.4   labeling_0.4.2   utf8_1.2.2      
#> [41] stringi_1.7.8    munsell_0.5.0    broom_1.0.1 

cat(paste(Sys.time(), Sys.timezone(), "\n"))

#> 2022-12-20 10:38:35 Europe/Zurich
```


## 2. Reproducing the thesis within a Docker container

Make sure that Docker with root rights is installed. Then run

```
make docker
```

This may take some time as TinyTeX needs to install several LaTeX packages (run
`make docker2` to compile only R code within the container but run LaTeX
locally). The Docker approach reruns the analyses in a Docker container which
encapsulates the computational environment (R and R package versions) that was
used in the original analysis. The only way this approach could become
non-reproducible is when the
[rocker/verse](https://hub.docker.com/r/rocker/verse/tags) base image becomes
unavailable and/or the MRAN snapshot of CRAN becomes unavailable.

## Reproducing the individual papers

The thesis contains six papers, `.tex` and figure output files for each of them
are already included in the repository. Code and data to reproduce them
individually can be found at

1) The assessment of replication success based on relative effect size:
<https://github.com/SamCH93/RSgolden/>

2) The sceptical Bayes factor for the assessment of replication success:
<https://gitlab.uzh.ch/samuel.pawel/BFScode> and
<https://gitlab.uzh.ch/samuel.pawel/BayesRep>

3) Bayesian approaches to designing replication studies:
<https://github.com/SamCH93/BAtDRS> and
<https://github.com/SamCH93/BayesRepDesign>

4) Reverse-Bayes methods for evidence assessment and research synthesis
<https://gitlab.uzh.ch/samuel.pawel/Reverse-Bayes-Code>

5) Comment on "Bayesian additional evidence for decision making under small
sample uncertainty": <https://github.com/SamCH93/BAEcomment>

6) Pitfalls and Potentials in Simulation Studies:
<https://github.com/SamCH93/SimPaper> and <https://github.com/LucasKook/ainet>

Archives of the git repositories are also provided in `source/paper-source`.
