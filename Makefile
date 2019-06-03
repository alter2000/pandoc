# vim:ts=4 sw=4
# All markdown files in the working directory
SRC = $(wildcard *.md)
PREFIX = $(HOME)/.pandoc
BIB = $(XDG_DOCUMENTS_DIR)/bibs/socbib-pandoc.bib
PDFS=$(SRC:.md=.pdf)
HTML=$(SRC:.md=.html)
TEX=$(SRC:.md=.tex)
DOCX=$(SRC:.md=.docx)
REVEALJS=$(SRC:.md=.rjs.html)

revealjs:	$(REVEALJS)

all:	$(PDFS) $(HTML) $(TEX) $(DOCX) $(REVEALJS)

pdf:	$(PDFS)
html:	$(HTML)
tex:	$(TEX)
docx:	$(DOCX)
mdown:	$(SRC)

%.html:	%.md
	pandoc -w html -o $@ $< \
		--self-contained \
		--css=$(PREFIX)/css/pandoc.css
		# --bibliography=$(BIB)

%.tex:	%.md
	pandoc -w latex -s -o $@ $< \
		--pdf-engine=pdflatex
		# --bibliography=$(BIB)

%.rjs.html:	%.md
	pandoc -w revealjs -o $@ $< \
		--self-contained \
		--mathjax \
		-V css=main.css \
		-V revealjs-url=$(HOME)/.pandoc/reveal.js

%.pdf:	%.md
	pandoc -s \
		--pdf-engine=pdflatex -o $@ $< \
		--bibliography=$(BIB)

%.docx:	%.md
	pandoc -s -o $@ $<  #--bibliography=$(BIB)

clean:
	rm -f *.html *.pdf *.tex *.aux *.log *.docx

.PHONY: clean revealjs all pdf html tex docx mdown
