%{
#include <stdio.h>
//#include "y.tab.h"

int yylex();
int yyparse(void);
int yyerror(char const *s);
extern int lines;   /* lexico le da valores */
%}

%token DIGIT
%token LEARN RET END NEXT TERM
%token INT FLOAT BOOL 
%token CHAR
%token ARR STR EOL
%token NAME
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GT LT GTE LTE

%start statement //cambiar a statementS?

%%
type: INT 
|   FLOAT 
|   BOOL 
|   CHAR 
|   STR
|   ARR
;

initialization: type NAME
;

initializations: initialization
|	initialization ',' initializations
;

expression: DIGIT
|	DIGIT '+' expression
|	DIGIT '-' expression
|	DIGIT '*' expression
|	DIGIT '/' expression
;

statement: initialization '=' expression
|   	NAME '=' expression  
|   	RET NAME 
;

/**
	statements: statement 
	|    statement EOL statements
	;
*/

comparator: EQ
|	NEQ
|	GT
|	LT
|	GTE
|	LTE
|	AND
|	OR
;

comparation: NAME
|	NAME comparator comparation
|	NOT comparation
;

controlStructure: IF '('comparation')''{'content'}'
|	LOOP'('DIGIT')''{'content'}'
|	LOOP FOR'('INT NAME',' RANGE'('DIGIT ',' DIGIT')'',' DIGIT')''{'content'}'
|	LOOP WHILE '('comparation')''{'content'}'
|	LOOP UNTIL '('comparation')''{'content'}'
;

content: statement		// keywords?
|	controlStructure
|	EOL
|	statement EOL content
|	controlStructure EOL content
;

method: METH NAME '('initializations')'':' type'{'content'}' 	// RETURN isnt forced to be use
|	METH NAME '('initializations')'':' type'{'content'}'
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
