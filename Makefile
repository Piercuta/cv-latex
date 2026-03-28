.PHONY: cv.pdf

CC = lualatex
DOCS_DIR = docs

resume.pdf: $(DOCS_DIR)/resume.tex
	$(CC) -output-directory=$(DOCS_DIR) $<

cv.pdf: $(DOCS_DIR)/cv.tex
	$(CC) -output-directory=$(DOCS_DIR) $<

clean:
	rm -rf $(DOCS_DIR)/*.pdf
