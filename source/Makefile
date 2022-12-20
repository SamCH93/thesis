all: cover pdf clean

cover: cover.tex
	pdflatex cover

tex: cover.pdf abstract.tex header.tex intro.Rnw outline.tex preface.tex thesis.Rnw bibliography.bib apalikedoiurl.bst
	R -e "knitr::knit('thesis.Rnw')" --vanilla

pdf: tex
# compile to pdf and generate bibliography
	-pdflatex thesis # continue with error with by using - at the start
	bibtex intro
	bibtex paper1
	bibtex paper2
	bibtex paper3
	bibtex paper4
	bibtex paper5
	bibtex paper6
	pdflatex thesis
	pdflatex thesis

pdf2:
# compile to pdf and generate bibliography *without requring tex recipe*
	-pdflatex thesis
	bibtex intro
	bibtex paper1
	bibtex paper2
	bibtex paper3
	bibtex paper4
	bibtex paper5
	bibtex paper6
	pdflatex thesis
	pdflatex thesis

clean:  
	-rm intro.tex thesis.tex *.aux *.log *.bbl *.out *.brf *.synctex.gz *.toc *.blg
	-rm -r .auctex-auto/
	-rm -r figure/
