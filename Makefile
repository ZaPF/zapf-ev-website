HUGO = hugo
SITE_OFFSET := 
OUTPUT_DIR := public
SOURCE_DIR := ./

INPUTS := static/
INPUTS += layouts/
INPUTS += content/

.PHONY: all test clean clean

FAVICON := static/favicon.png
FAVICON_SVG := resources/img/favicon.svg

all: ${OUTPUT_DIR}

$(FAVICON): $(FAVICON_SVG)
	convert $<  -bordercolor white -border 0 \
	\( -clone 0 -resize 16x16 \) \
	\( -clone 0 -resize 32x32 \) \
	\( -clone 0 -resize 48x48 \) \
	\( -clone 0 -resize 64x64 \) \
	-delete 0 -alpha off -colors 256 $@

static:
	mkdir -p static

layouts:
	mkdir -p layouts

basedir: $(FAVICON)
	@echo "Createing output dir: ${OUTPUT_DIR}"
	@mkdir -p ${OUTPUT_DIR}

${OUTPUT_DIR}: ${INPUTS} basedir
	${HUGO} --source=${SOURCE_DIR}

test:
	${HUGO} server --buildDrafts --source=./

clean:
	@rm -rf $(FAVICON)
	@rm -rf ${OUTPUT_DIR} public
