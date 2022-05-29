%{
#include <stdio.h>

#include "table.h" /* tabla de símbolos */

int yylex();
int yyparse(void);
int yyerror(char const *s);
extern FILE *yyin;
extern int lines;   /* lexico le da valores */

#define YYDEBUG 1 //debugging

void init() { /* iniciar tabla de símbolos */
	insertar("void", tipo, NULL);
	voidp = top;
	insertar("int", tipo, NULL);
	insertar("dbl", tipo, NULL);
}

%}

%token INC DEC MULT_ASSIGN DIV_ASSIGN
%token LEARN ARROW RET END NEXT TERM
%token INT FLOAT BOOL CHAR VOID ARR STR
%token V_VOID
%token NAME
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GT LT GTE LTE
%token TRUE FALSE

// TIPOS

// primitivos
%token <my_int> DIGIT
%token <my_float> V_FLOAT
%token <my_bool> V_BOOL
%token <my_char> V_CHAR

//compuestos
//%token <my_arr> V_ARR
%token <my_str> V_STR

%union{
	int my_int;
	float my_float;
	bool my_bool;
	char my_char;
	// Compuestos
	//int* my_arr;
	char* my_str;
}





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
|	print
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
|	len
|	'{' list '}'
;

list: DIGIT
|	DIGIT ',' list;

operand: DIGIT
|	NAME
|	NAME '[' DIGIT ']'
|	NAME '[' NAME ']' //multidimensionales?
|	NAME '(' nameContainer ')' //function call
|	V_STR
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

print: PRINT '(' V_STR ')'
|	PRINT '(' expression ')'
;

/*print: LEN '(' NAME ')'
|	LEN '(' expression ')'
;*/

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
	yydebug = 1; //1 = enabled

	//init(); //iniciar tabla de símbolos

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
