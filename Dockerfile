## set R version (https://hub.docker.com/r/rocker/verse/tags)
FROM rocker/verse:4.2

## name of the manuscript (as in Makefile and paper/Makefile)
ENV FILE=thesis

## should PDF be compiled within docker?
## by default set to False because tinytex takes ages to download and install
## LaTeX packages
ENV pdfdocker=false

## set up directories
RUN mkdir /output \
    && mkdir /analysis
COPY source /analysis
COPY CRANpackages.txt /analysis
WORKDIR /analysis

## install R packages from CRAN the last day of the specified R version;
## - add packages required for the analysis to the CRANpackages.txt file
## - increase ncpus when installing many packages (and more than 1 CPU available)
RUN install2.r --error --skipinstalled --ncpus -4 \
    `cat CRANpackages.txt`

## knit Rnw to tex and compile tex to PDF
CMD if [ "$pdfdocker" = "false" ] ; then \
    echo "compiling PDF outside Docker" \
    ## knit Rnw to tex and compile tex outside docker to PDF
    && make tex \
    && mv thesis.tex intro.tex /output \
    && mkdir -p /output/figure \
    && mv figure/* /output/figure/ ; \
    else \
    echo "compiling PDF inside Docker" \
    ## fix tinytex version
    ## && Rscript -e "install.packages('tinytex')" --vanilla \
    ## && Rscript -e "tinytex::install_tinytex(force = TRUE, bundle = 'TinyTeX', version = '2023.03.21', extra_packages = c('doi', 'koma-script'))" --vanilla \
    ## run knitr to install all LaTeX packages
    && Rscript -e "tinytex::install_tinytex()" --vanilla \
    && Rscript -e "knitr::knit2pdf('thesis.Rnw')" --vanilla \
    ## now run make command because the compiling requires custom pdflatex
    ## commands which knitr doesn't know
    && make pdf \
    && mv thesis.pdf /output ; \
    fi \
    ## change file permission of output files
    && chmod -R 777 /output/
