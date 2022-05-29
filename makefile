all: comp $(F)
	./comp $(F)

clean:
	rm -f lex.yy.c *.tab.? parser.output comp .DS_Store *~

comp: myparser.tab.c lex.yy.c tab.c
	cc y.tab.c lex.yy.c -lfl -o comp

lex.yy.c: myscanner.l myparser.tab.h
	flex myscanner.l

myparser.tab.c: myparser.y tab.h tab.c
	bison -ydv myparser.y

