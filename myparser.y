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
%token INC DEC MULT_ASSIGN DIV_ASSIGN
%token LEARN ARROW RET END NEXT TERM
%token INT FLOAT BOOL CHAR VOID ARR STR
%token V_INT V_FLOAT V_BOOL V_CHAR V_VOID V_ARR V_STR
%token NAME
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GT LT GTE LTE
%token TRUE FALSE

%right '=' INC DEC MULT_ASSIGN DIV_ASSIGN
//lógicas primero or luego and
//equals
//comparativas
%left '+' '-'
%left '*' '/' '%' //Comprobar si módulo va aquí
%left '^'
//not

%start program //cambiar a statementS?

%%

program: /* empty */ { printf("Empty input\n"); }
|	import program
|	content;

import: LEARN ARROW V_STR
;

content: /*initialization content		// keywords?
|*/	statement
|	content statement		// keywords?
|	controlStructure
|	content controlStructure
|	method
|	content method
//|	EOL
//|	statement EOL content
//|	controlStructure EOL content
;

statement: initialization
| 	initialization '=' expression
|   NAME '=' expression  
| 	initialization INC expression
|   NAME INC expression  
| 	initialization DEC expression
|   NAME DEC expression   
|   RET 
|	RET expression
|	END 
|	NEXT
|	TERM
;

initialization: typeContainer nameContainer
;

nameContainer: NAME
|	NAME ',' nameContainer
;

param: typeContainer NAME
|	typeContainer NAME ',' param
;

/*expression: DIGIT
|	DIGIT '+' expression
|	DIGIT '-' expression
|	DIGIT '*' expression
|	DIGIT '/' expression
;*/

expression: operand
|	operand '+' expression
|	operand '-' expression
|	operand '*' expression
|	operand '/' expression
|	operand '%' expression
|	operand '^' expression
|	'{' list '}'
;

list: DIGIT
|	DIGIT ',' list;

operand: DIGIT
|	NAME
|	NAME '[' DIGIT ']'
|	NAME '[' NAME ']' //multidimensionales?
|	NAME '(' nameContainer ')' //function call
;

controlStructure: IF '(' comparation ')' '{'content'}'
|	LOOP '(' DIGIT ')' '{' content '}'
|	LOOP FOR '(' INT NAME ',' NAME comparator len ',' DIGIT ')' '{' content '}'
//|	LOOP FOR '(' INT NAME ',' RANGE '(' DIGIT ',' DIGIT ')' ',' DIGIT ')' '{' content '}'
|	LOOP WHILE '(' comparation ')' '{' content '}'
|	LOOP UNTIL '(' comparation ')' '{' content '}'
;

len: LEN '(' NAME ')'
;

print: LEN '(' NAME ')'
|	LEN '(' expression ')'
;

method: METH NAME '('param')'':' typeContainer '{'content'}' 	// RETURN isnt forced to be use
//|	METH NAME '('initializations')'':' type'{'content'}'
;

typeContainer: type
|	type '[' ']'
|	type '[' DIGIT ']'
|	type '[' NAME ']'
;

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
|	'>'
|	'<'
|	GTE
|	LTE
|	AND
|	OR
;

comparation: NAME
|	NAME comparator comparation
|	NOT NAME comparator comparation
|	NOT '(' comparation ')'
|	NOT '(' expression ')'
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
	yydebug = 0; //1 = enabled
	if (argc == 2){
		yyin = fopen(argv[1], "r");
		yyparse();
	}
	return 0;
}

int yyerror(char const *s){
	fprintf(stderr, "error in line %d: %s\n", lines, s);
	//fprintf("yyparse: %d", yyparse());
}
