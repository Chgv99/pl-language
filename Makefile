all: myparser $(F)
	./myparser $(F)

clean:
	rm -f lex.yy.c *.tab.? myparser.output myparser .DS_Store *~

myparser: y.tab.c lex.yy.c table.c
	cc -o myparser table.c lex.yy.c y.tab.c -lfl

lex.yy.c: myscanner.l y.tab.h
	flex myscanner.l

myparser.tab.c: myparser.y table.c table.h
	bison -ydv myparser.y

