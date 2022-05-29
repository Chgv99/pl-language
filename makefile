all: comp $(F)
		./comp $(F)

clean:
	rm -f lex.yy.c *.tab.? parser.output comp .DS_Store *~

comp: myparser.tab.c lex.yy.c myparser.tab.c
	cc -lfl y.tab.c lex.yy.c -o comp

lex.yy.c: myscanner.l myparser.tab.h
	flex myscanner.l

myparser.tab.c: myparser.y myparser.tab.h
	bison -ydv myparser.y
