TEXI = hello.texi
INFO = hello.info
PDF  = hello.pdf

all: info pdf man

info: $(TEXI)
	makeinfo $(TEXI)

pdf: $(TEXI)
	texi2pdf $(TEXI)

man:

clean:
	rm -f $(INFO) $(PDF) *.aux *.log *.toc *.cp *.fn *.ky *.pg *.tp *.vr *.cps

.PHONY: all info pdf clean

