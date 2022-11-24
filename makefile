all: cover thesis clean

cover: cover.tex
	pdflatex cover

# thesis: cover abstract.tex header.tex intro.tex outline.tex preface.tex summary.tex thesis.tex bibliography.bib apalikedoiurl.bst
# # compile to pdf and generate bibliography
# 	pdflatex thesis
# 	bibtex thesis
# 	pdflatex thesis
# 	pdflatex thesis

tex: cover abstract.tex header.tex intro.Rnw outline.tex preface.tex thesis.Rnw bibliography.bib apalikedoiurl.bst
	R -e "knitr::knit('thesis.Rnw')" --vanilla

thesis: tex
# carry over clickable links from included pdfs to work with includepdf via pax
	# java -jar /usr/share/texlive/texmf-dist/scripts/pax/pax.jar pdf/2022-Pawel_Held.pdf
	# java -jar /usr/share/texlive/texmf-dist/scripts/pax/pax.jar pdf/2021-Held_etal.pdf
	# java -jar /usr/share/texlive/texmf-dist/scripts/pax/pax.jar pdf/2022-Held_etal.pdf
	# java -jar /usr/share/texlive/texmf-dist/scripts/pax/pax.jar pdf/2022-Pawel_etal.pdf
	# java -jar /usr/share/texlive/texmf-dist/scripts/pax/pax.jar pdf/2022-Pawel_etalb.pdf
# compile to pdf and generate bibliography
	-pdflatex thesis
	bibtex intro # continue with error with by using - at the start
	bibtex paper1
	# bibtex paper2
	bibtex paper3
	# bibtex paper4
	bibtex paper5
	# bibtex paper6
	pdflatex thesis
	pdflatex thesis

clean:  
	rm *.aux *.log *.bbl *.out *.brf *.synctex.gz *.toc *.blg
	rm -r .auctex-auto/
