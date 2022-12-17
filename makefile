all: cover thesis clean

cover: cover.tex
	pdflatex cover

tex: cover abstract.tex header.tex intro.Rnw outline.tex preface.tex thesis.Rnw bibliography.bib apalikedoiurl.bst
	R -e "knitr::knit('thesis.Rnw')" --vanilla

thesis: tex
# compile to pdf and generate bibliography
	-pdflatex thesis
	bibtex intro # continue with error with by using - at the start
	bibtex paper1
	bibtex paper2
	bibtex paper3
	bibtex paper4
	bibtex paper5
	bibtex paper6
	pdflatex thesis
	pdflatex thesis

clean:  
	rm *.aux *.log *.bbl *.out *.brf *.synctex.gz *.toc *.blg
	rm -r .auctex-auto/
