all: myparser $(F)
	@./myparser $(F)
	@echo "############################"
	@echo "> INPUT:" $(F)
	@cat $(F)
	@echo "\n############################"
	@echo "> OUTPUT:"
	@(cd Q; ./IQ ../output.q.c)
	@echo "############################"

clean:
	@rm -f lex.yy.c *.tab.? myparser.output myparser .DS_Store *~
	@rm -f output.q.c
	@rm -f IQ-cpp.q.c

myparser: y.tab.c lex.yy.c table.c
	@gcc y.tab.c lex.yy.c table.c -lfl -o myparser

lex.yy.c: myscanner.l y.tab.h
	@flex myscanner.l

y.tab.c: myparser.y table.c table.h
	@bison -ydv myparser.y