FILE=main

LATEX=lualatex
BIBTEX=bibtex

LATEX_OPTS=-interaction=nonstopmode -halt-on-error

all: document

four-times:
	./helpers/four-times.sh

document:
	touch $(FILE).idx
	makeindex $(FILE).idx
	$(LATEX) $(LATEX_OPTS) $(FILE).tex

html:
	./helpers/generate_html.sh

epub:
	./helpers/generate_epub.sh $(FILE)

epub-validate:
	EPUBCHECK=~/bin/epubcheck asciidoctor-epub3 -D output -a ebook-validate main.adoc

mobi:
	./helpers/generate_mobi.sh $(FILE)

preview:
	latexmk -pvc $(FILE).tex

chapters-to-asciidoc:
	./helpers/chapters_to_asciidoc.sh

chapters-to-docx:
	./helpers/chapters_to_docx.sh

stylus-watch:
	stylus -w ./vendor/asciidoctor-epub3/assets/styles/*.styl -o ./vendor/asciidoctor-epub3/data/styles/

clean:
	+rm -fv $(FILE).{dvi,ps,pdf,aux,log,bbl,blg}

