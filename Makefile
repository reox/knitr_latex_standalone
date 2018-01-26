OUT := main.pdf

# The main tex file is defined by the pdf name
TEX := $(patsubst %.pdf,%.tex,${OUT})

# Define all latex files that are required for building
PREQ := $(patsubst %.Rtex,%.tex,$(wildcard sections/*.Rtex))

all: ${OUT}

${TEX}: ${PREQ}

%.tex: %.Rtex
	R -e 'library(knitr);setwd("$(dir $<)");knit("$(notdir $<)")'

%.pdf: %.tex
	latexmk -bibtex -lualatex -use-make $<

# Clean up - latexmk -C does not clean all files...
clean:
	latexmk -C
	rm $(patsubst %.pdf,%.bbl,${OUT}) $(patsubst %.pdf,%.run.xml,${OUT}) || exit 0
