%{
#include <stdio.h>
//#include "y.tab.h"

int yylex();
int yyerror(char *s);
%}

/* tokens */
%token LEARN RET END NEXT TERM
%token /*<num>*/ INT FLOAT BOOL 
%token CHAR
%token ARR STR EOL
%token /*<name>*/ NAME
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GTE LTE

/*%union {
  struct ast *a;
  char[] name;
  double num;
}*/

//%type <a> exp factor term

%start statements

%%

statements: statements statement
	  | statement
	  ;

statement: NAME '=' expression EOL
	 | NAME EOL
	 ;

expression: INT
	  | INT '+' INT
	  | INT '-' INT
	  ;
//line:
//    | line exp EOL { printf("= %d\n", $2); }
//;

%%

main (int argc, char **argv){
	//Antes del análisis
	yyparse();
	//Después del análisis
}

yyerror(char *s){
	fprintf(stderr, "error: %s\n", s);
}
