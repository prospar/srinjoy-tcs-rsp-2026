# Main document name (without extension)
MAIN = proposal

# Compiler and options
LATEXMK     = latexmk
LATEXFLAGS  = 

# All TeX source files (main + includes)
TEXSRC := $(wildcard *.tex) \
          $(wildcard chapters/*.tex) \
          $(wildcard sections/*.tex)

# Bibliography files
BIBSRC := $(wildcard *.bib)

# Figures
FIGSRC := $(wildcard figs/*.{pdf,png,jpg,eps,drawio,xml,drawio.pdf})

STYCLS := $(wildcard *.sty *.cls)

# Default build. The first rule in a Makefile is the one executed by default
# ("make"). It should always be the "all" rule, so that "make" and "make all"
# are identical.
all: $(MAIN).pdf

build: $(MAIN).pdf

# '$@' is a variable holding the name of the target, and '$<' is a variable
# holding the (first) dependency of a rule.

# Full PDF build (latexmk handles multiple runs and bibtex)
$(MAIN).pdf: $(TEXSRC) $(BIBSRC) $(FIGSRC) $(STYCLS)
	$(LATEXMK) $(LATEXFLAGS) $(MAIN).tex

# Watch for changes and rebuild automatically
watch:
	$(LATEXMK) $(LATEXFLAGS) -pvc $(MAIN).tex

# Open PDF in Okular
open: $(MAIN).pdf
	okular $(MAIN).pdf &

# Clean auxiliary files (keep PDF)
clean:
	$(LATEXMK) -c
	rm -f $(MAIN).bbl $(MAIN).blg $(MAIN).run.xml $(MAIN).bcf $(MAIN).aux $(MAIN).log $(MAIN).nav $(MAIN).snm $(MAIN).toc $(MAIN).vrb
	rm -rf auto tmp

# Full clean (including PDF)
allclean: clean
	$(LATEXMK) -C
	rm -f $(MAIN).pdf

# You want latexmk to always run, because make does not have all the info (e.g.,
# new figures added). Include non-file targets in .PHONY so they are run
# regardless of any file of the given name existing.
.PHONY: all build clean allclean open watch $(MAIN).pdf
