%{
#include <stdio.h>
//#include "y.tab.h"

int yylex();
int yyparse(void);
int yyerror(char const *s);
extern FILE *yyin;
extern int lines;   /* lexico le da valores */

#define YYDEBUG 1 //debugging
%}

%token DIGIT
%token LEARN RET END NEXT TERM
%token INT FLOAT BOOL CHAR VOID
%token ARR STR EOL
%token NAME
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GT LT GTE LTE
%token TRUE FALSE

%left '+' '-'
%left '*' '/'
%left '^'

%start program //cambiar a statementS?

%%

program: content;

content: /* empty */ { printf("Empty input\n"); }
|	content statement		// keywords?
//|	controlStructure
//|	method
//|	EOL
//|	statement EOL content
//|	controlStructure EOL content
;

statement: initialization
| 	initialization '=' expression
|   NAME '=' expression  
|   RET NAME 
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

controlStructure: IF '('comparation')''{'content'}'
|	LOOP'('DIGIT')''{'content'}'
|	LOOP FOR'('INT NAME',' RANGE'('DIGIT ',' DIGIT')'',' DIGIT')''{'content'}'
|	LOOP WHILE '('comparation')''{'content'}'
|	LOOP UNTIL '('comparation')''{'content'}'
;

method: METH NAME '('initialization')'':' type'{'content'}' 	// RETURN isnt forced to be use
|	METH NAME '('initializations')'':' type'{'content'}'

type: INT 
|   FLOAT 
|   BOOL 
|   CHAR 
|   STR
|   ARR
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

%%

/*int main (int argc, char **argv){
	yydebug = 1; //debugging
	//Antes del análisis
	printf("Comienza el análisis\n");
	yyparse();
	//Después del análisis
	printf("Análisis finalizado\n");
}*/
int main (int argc, char **argv){
	yydebug = 1; //1 = enabled
	if (argc == 2){
		yyin = fopen(argv[1], "r");
		yyparse();
	}
	return 0;
}

int yyerror(char const *s){
	fprintf(stderr, "error in line %d: %s\n", lines, s);
}
