# The basic syntax: 'latexmk $OPTIONS -pdflatex="$COMPILATION_COMMAND
# $PDFLATEX_OPTIONS %O %S" texfile'.

# It is recommended to use single quotes. %O is for options, %S is for the
# source file.

# Example: 'latexmk -pdf -view=pdf -time -silent -pdflatex="pdflatex -synctex=1 --shell-escape -interaction=nonstopmode -file-line-error %O %S" paper'

# Simple "scalar" variables have names that begin with a $ character and array
# variables have names that begin with a @ character. Strings should be enclosed
# in single quotes.

# Tell latexmk to call the pdflatex backend with specified options.
# "-interaction=nonstopmode" means that pdflatex automatically goes through the
# compilation without requiring user input. The user does not need to type X to
# quit the compilation on error. "--interaction=batchmode" outputs less verbose
# output, it outputs only succinct, important information.
# "-interaction=errorstopmode" stops and waits for user input at the first error
# (latexmk will stop). %O is replaced by latexmk with the options given to
# latexmk, and %S is replaced with the source file name. The ".tex" extension is
# automatically added to the source file.

# "-shell-escape" is required the document needs to run external programs during compilation (e.g., minted).
$latex = 'env TEXINPUTS=".:$HOME/texmf//:$TEXINPUTS" pdflatex -synctex=1
-interaction=errorstopmode -file-line-error %O %S';

# Define output directories, all build files will now be placed in this
# directory. If $aux_dir is not set, but $out_dir is set, then $aux_dir is set
# to $out_dir.

$aux_dir = './.'; # auxiliary files (aux, log, etc)
$out_dir = './.';

# Automatically detect the main file (any .tex in current dir if none given)
@default_files = glob('*.tex');

# If $bibtex_use is set to 0 or 1, bbl files are always treated as
# non-regeneratable. If $bibtex_use is set to 1.5, bbl files are counted as
# non-regeneratable conditionally: If the bib file exists, then bbl files are
# regeneratable, and are deleted in a clean up. But if $bibtex_use is 1.5 and a
# bib file does not exist, then the bbl files are treated as non-regeneratable
# and hence are not deleted. If $bibtex_use is set to 2, bbl files are always
# treated as regeneratable, and are deleted in a cleanup.

# The possible values of $bibtex_use are: 0: never use BibTeX or biber; never
# delete .bbl files in a cleanup. 1: only use bibtex or biber if the bib files
# exist; never delete .bbl files in a cleanup. 1.5: only use bibtex or biber if
# the bib files exist; conditionally delete .bbl files in a cleanup (i.e.,
# delete them only when the bib files all exist). 2: run bibtex or biber
# whenever it appears necessary to update the bbl files, without testing for the
# existence of the bib files; always delete .bbl files in a cleanup. Note that
# the value 1.5 does not work properly if the document uses biber instead of
# bibtex.

# Use 1 to run bibtex to regenerate .bbl file if needed.
$bibtex_use = 0;
$bibtex = 'bibtex %O %B';

$view = 'pdf';

# Generate tex->pdf using the command specified by the $pdflatex variable (-pdf
# option). Use "$pdf_mode = 2" for tex -> ps -> pdf. Use "$postscript_mode = 1"
# for tex -> ps.
$pdf_mode = 1;

# Specify extra file extensions that should be cleaned, aux blg bbl files are
# important.

# Delete temporary regeneratable files with -c, except dvi, postscript, and pdf.
# In addition, files specified by the $clean_ext and @generated_exts
# configuration variables are removed.

# Delete .pdf/.ps/.dvi files with -C. In addition, delete files included in the
# $clean_full_ext configuration variable.

$clean_ext = "aux bbl bcf blg fdb_latexmk fls lof log lot out nav run.xml snm synctex.gz toc vrb xdv";

$clean_full_ext = "pdf";

# Specify 1 for full cleanup, 2 for cleanup except for .dvi, .ps and .pdf files,
# 3 for cleanup except for dep and aux files.
$cleanup_mode = 1;

# Monitor all input files for changes, recompile the files if needed, and update
# the output with the -pvc option. Use "latexmk -pvc".

# The preview-continuous option -pvc can only work with one file. So in this
# case you will normally only specify one filename on the command line. Options
# -p, -pv and -pvc are mutually exclusive. So each of these options turns the
# others off.

# The -pvc option also turns off force mode (-f), as is normally best for
# continuous preview mode. If you really want force mode, use the options in the
# order "-pvc -f", i.e., use "latexmk -pvc -f".
$preview_continuous_mode = 0;

$preview_mode =0;

$pdf_previewer = 'start okular %O %S';

# If nonzero, continue processing past minor latex errors including unrecognized
# cross references. Recommended to turn off with pvc mode. Equivalent to
# specifying the -f option.
$force_mode = 0;

# Force full document processing, process files regardless of timestamps, -g
# option.
$go_mode = 0;

$max_repeat = 4;
# Parallel compilation (up to 4 jobs)
$jobs = 4;

# quiet is same as silent. The default setting is verbose. The -silent option in
# the invocation of latexmk results in the replacement of %O by
# "-interaction=batchmode". Silence most chatter, but show errors and timings.
$silent = 0;

$show_time=0;
