%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>

#include "table.h" /* tabla de símbolos */

int yylex();
int yyparse(void);
int yyerror(char const *s);
extern FILE *yyin;
extern int lines;   /* lexico le da valores */

#define YYDEBUG 1 //debugging

struct reg* voidp;

//list<char*> init_stack;
char** init_stack;

char* _type;

void init_s_t() { /* iniciar tabla de símbolos */
	insertar("void", tipo, NULL);
	voidp = top;
	insertar("int", tipo, NULL);
	insertar("dbl", tipo, NULL);
}

void init(){
	init_stack = malloc(10 * sizeof(char**));
	init_s_t();
}

%}

%token INC DEC MULT_ASSIGN DIV_ASSIGN
%token LEARN ARROW RET END NEXT TERM
%token V_VOID
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GT LT GTE LTE
%token TRUE FALSE

// TIPOS

// primitivos
%token <id> NAME
%token <id> INT FLOAT BOOL CHAR VOID ARR STR
%token <my_int> DIGIT
%token <my_float> V_FLOAT
%token <my_bool> V_BOOL
%token <my_char> V_CHAR

//compuestos
//%token <my_arr> V_ARR
%token <my_str> V_STR

%union{
	char* id;

	int my_int;
	float my_float;
	bool my_bool;
	char my_char;
	// Compuestos
	//int* my_arr;
	char* my_str;
}

%type<id> nameContainer;
%type<id> typeContainer;



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

initialization: typeContainer nameContainer { 
												struct reg *tipo = (struct reg *) malloc(sizeof(struct reg));
												enum category cat;
												tipo->id = _type; tipo->cat = cat;
												insertar(init_stack[0], v_local, tipo); 
											}
;

nameContainer: NAME	{ 	init_stack[0] = $1;	}
|	NAME ',' nameContainer 	{ 	//init_stack.insert(0, $1);
								//printf(init_stack);
							}
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
|	NAME '(' paramContainer ')' //function call
|	V_STR
;

paramContainer: NAME
|	NAME ',' paramContainer
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

type: INT 	{ _type = $1; }
|   FLOAT 	{ _type = $1; }
|   BOOL 	{ _type = $1; }
|   CHAR 	{ _type = $1; }
|   STR 	{ _type = $1; }
|   ARR 	{ _type = $1; }
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
		init(); //iniciar tabla de símbolos
		dump("t.s. inicial");
		yyparse();
		dump("t.s. final");
	}
	return 0;
}

int yyerror(char const *s){
	dump("ERROR");
	fprintf(stderr, "error in line %d: %s\n", lines, s);
	//fprintf("yyparse: %d", yyparse());
}
