.PHONY: cv.pdf cv-long.pdf cv-long-fr.pdf

CC = lualatex
DOCS_DIR = docs

resume.pdf: $(DOCS_DIR)/resume.tex
	$(CC) -output-directory=$(DOCS_DIR) $<

# Default CV (shorter experience + compact skills, English)
cv.pdf: $(DOCS_DIR)/cv.tex
	$(CC) -output-directory=$(DOCS_DIR) $<

# Extended CV (detailed experience + expanded skills, English)
cv-long.pdf: $(DOCS_DIR)/cv-long.tex
	$(CC) -output-directory=$(DOCS_DIR) $<

# Extended CV in French (IT francophone tone)
cv-long-fr.pdf: $(DOCS_DIR)/cv-long-fr.tex
	$(CC) -output-directory=$(DOCS_DIR) $<

clean:
	rm -rf $(DOCS_DIR)/*.pdf
