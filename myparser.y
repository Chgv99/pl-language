%{
#include <stdio.h>
#include "y.tab.h"

extern int yylex();
extern int yyparse(void);
extern int yyerror(char *s);
%}

%token LEARN RET END NEXT TERM
%token INT FLOAT BOOL 
%token CHAR
%token ARR STR EOL
%token NAME
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GTE LTE

%start statements

%%

statements: INT
	  | statements statement
	  | statement
	  ;

statement: NAME '=' expression
	 | NAME
	 ;

expression: INT
	  | INT '+' INT
	  | INT '-' INT
	  ;
//line:
//    | line exp EOL { printf("= %d\n", $2); }
//;

%%

int main (int argc, char **argv){
	//Antes del análisis
	printf("Comienza el análisis\n");
	yyparse();
	//Después del análisis
	printf("Análisis finalizado\n");
}

int yyerror(char *s){
	fprintf(stderr, "error: %s\n", s);
}
