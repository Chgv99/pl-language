all: myparser $(F)
	./myparser $(F)
	echo $(F)

clean:
	rm -f lex.yy.c *.tab.? myparser.output myparser .DS_Store *~

myparser: y.tab.c lex.yy.c table.c
	gcc y.tab.c lex.yy.c table.c -lfl -o myparser

lex.yy.c: myscanner.l y.tab.h
	flex myscanner.l

y.tab.c: myparser.y table.c table.h
	bison -ydv myparser.y