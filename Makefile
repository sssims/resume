FILENAME = sims_shane_resume

all :
	pdflatex ${FILENAME}.tex
	./embed_fonts.sh ${FILENAME}.pdf
	rm ${FILENAME}.log
	rm ${FILENAME}.aux
