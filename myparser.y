%{
#include <stdio.h>
//#include "y.tab.h"

int yylex();
int yyparse(void);
int yyerror(char const *s);
extern int lines;   /* lexico le da valores */
%}

%token LEARN RET END NEXT TERM
%token INT FLOAT BOOL 
%token CHAR
%token ARR STR EOL
%token NAME
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GTE LTE

%start statement //cambiar a statementS?

%%

initialization: INT NAME
|	FLOAT NAME
|	BOOL NAME
|	CHAR NAME

expression: ; //

statement: initialization '=' expression //punto y coma??
|	NAME '=' expression
|	//NAME '=' //valor
;

/*statements: INT
	  | statements statement
	  | statement
	  ;

statement: NAME '=' expression
	 | NAME
	 ;

expression: INT
	  | INT '+' INT
	  | INT '-' INT
	  ;*/
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

int yyerror(char const *s){
	fprintf(stderr, "error in line %d: %s\n", lines, s);
}
