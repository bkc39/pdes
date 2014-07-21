SRC_DIRS=introduction transport laplace
BUILD_DIR=build

SRC:=$(foreach sdir,$(SRC_DIRS),$(wildcard $(sdir)/*.tex))
PDFS:=$(addprefix $(BUILD_DIR)/,$(patsubst %.tex,%.pdf,$(SRC)))

LATEX=latexmk
LATEXMK_OPTIONS=\
	-pdf \
	-silent \
	-f

LATEX_TMP_EXTS=.aux .log .fls .fdb_latexmk .out

vpath %.tex $(SRC_DIRS)

.PHONY:all build clean

all: $(BUILD_DIR) pdfs

pdfs: $(PDFS)

$(BUILD_DIR):
	@mkdir -p $@

$(BUILD_DIR)/%.pdf:%.tex $(BUILD_DIR)
	$(LATEX) $(LATEXMK_OPTIONS) \
		-output-directory=$(addprefix $(BUILD_DIR)/,$(dir $<)) $<

clean: force
	@rm -rf $(BUILD_DIR)

force:
