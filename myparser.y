%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>

#include "table.h" /* tabla de símbolos */

int yylex();
int yyparse(void);
int yyerror(char const *s);
void gc(char* str, int val);
extern FILE *yyin;
extern int lines;   /* lexico */
extern int chars;	/* lexico */
extern int _scope;   /* lexico */

#define YYDEBUG 1 //debugging

FILE *qfile;
char *qfileName = "output.q.c";

int lineSize;
char* line;

struct reg* voidp;

//list<char*> init_stack;
char** init_stack;

enum type _type;

int _tag;

//int _scope;

void init_s_t() { /* iniciar tabla de símbolos */
	insertar("void", tipo, nada);
	voidp = top;
	//insertar("int", tipo, nada);
	//insertar("dbl", tipo, nada);
}

void init(){
	init_stack = (char**) malloc(10 * sizeof(char*));
	_scope = 0; // Ámbito Global (flex)
	_tag = 1; 		//0 reservado para comienzo de fichero en código Q
	init_s_t();
}

int tag() {
	return _tag++;
}

/*void deleteScope(){
	while(struct reg* var = buscar_scope(_scope)){
		eliminar(var->id)
	}
	_scope--;
}*/

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

content: statement					//only one instruction
|	content statement				//multiple instructions ... ¿keywords?
|	controlStructure				//only one CS
|	content controlStructure		//multiple CS
|	method							//only one method
|	content method					//multiple methods
//|	EOL
//|	statement EOL content
//|	controlStructure EOL content
;

statement: initialization
| 	initialization '=' expression
|	initializationArray '=' expressionArray
|   NAME '=' expression  	{	// Asignación
								struct reg* var = buscar($1);
								if (var != NULL){
									printf("variable %s utilizable (line: %d)\n", $1, lines);
								} else printf("variable %s no utilizable (line: %d)\n", $1, lines);
							}
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
												/**char* e = "ey";
												init_stack[0] = e;
												struct reg* tipo = (struct reg*) malloc(sizeof(struct reg));
												enum category cat;
												tipo->id = _type; tipo->cat = cat;
												insertar(init_stack[0], v_local, tipo); */
											}
;

initializationArray: typeContainer '[' DIGIT ']' NAME
;


nameContainer: NAME			{ 	insertar($1, v_local, _type);	}
|	NAME ',' nameContainer 	{ 	insertar($1, v_local, _type);	}
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
//|	'{' list '}'
;

expressionArray: '{' digitContainer '}'
;

//list: DIGIT
//|	DIGIT ',' list;

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

digitContainer: DIGIT
|	DIGIT ',' digitContainer
;

/*
L 0:
	R0 = i(0x11FF0);	// digit
	R1 = R0 > 0;			// loop digit times
	R0 = R0 - 1;		// negativo (?)
	IF (!R1) GT(1);
	#content
	GT(0);
L 1:					//while salida
*/


controlStructure: IF '(' comparation ')' increaseScope content decreaseScope
|		LOOP 				{$<my_int>$ = tag(); gc("L %d:\n", $<my_int>$);}							//L N1:
		'(' DIGIT ')'		{$<my_int>$ = tag(); gc("R1 = R0 > 0;\nIF(!R1) GT(%d);\n",$<my_int>$);}		//R1 = R0 > 0; 		condición
																										//IF (!R1) GT(N2);	condición
		increaseScope		{}
		content 			{/*gc("%s", $7);*/} 														//subárbol
		decreaseScope		{gc("GT(%d);\n", $<my_int>1); gc("L %d:\n",$<my_int>3);}						//GT(N1);
																										//L N2:
|	LOOP FOR '(' INT NAME ',' NAME comparator len ',' DIGIT ')' increaseScope content decreaseScope
//|	LOOP FOR '(' INT NAME ',' RANGE '(' DIGIT ',' DIGIT ')' ',' DIGIT ')' '{' content '}'
|	LOOP WHILE '(' comparation ')' increaseScope content decreaseScope
|	LOOP UNTIL '(' comparation ')' increaseScope content decreaseScope
;

increaseScope: '{' 	{ _scope++; };

decreaseScope: '}' 	{ 	eliminar_scope(_scope);
						_scope--;
					};

len: LEN '(' NAME ')'
;

print: PRINT '(' V_STR ')'
|	PRINT '(' expression ')'
;

/*print: LEN '(' NAME ')'
|	LEN '(' expression ')'
;*/

method: METH NAME '('param')' 	{	// Add params to inner scope
									/*while (){

									}*/
								}':' typeContainer increaseScope content decreaseScope 	// RETURN isnt forced to be use
//|	METH NAME '('initializations')'':' type'{'content'}'
;

typeContainer: type
|	type '[' ']'
|	type '[' DIGIT ']'
|	type '[' NAME ']'
;

type: INT 	{ $<id>$ = INT; }//_type = entero; }
|   FLOAT 	{ $<id>$ = FLOAT; }//_type = flotante; }
|   BOOL 	{ $<id>$ = BOOL; }//_type = booleano; }
|   CHAR 	{ $<id>$ = CHAR; }//_type = caracter; }
//|   STR 	{ _type = $1; }
//|   ARR 	{_type = $1; }
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

// Implementación temporal para enteros
/*void gc(char* str, ...){

	va_list ap;
	int val;
	char c, *p, *s;

	va_start(ap, fmt);
	while (*fmt){
		val = va_arg(ap, int);
		snprintf(line,lineSize, str, val);
		*fmt++;
    }
	va_end(ap);
}*/

// Implementación temporal para enteros
void gc(char* str, int val){
	snprintf(line, lineSize, str, val);
	fputs(str, qfile);
}

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

	lineSize = sizeof(char*) * 500;
	line = (char*) malloc(lineSize);

	printf("args = %d\n", argc);
	if (argc == 2){
		yyin = fopen(argv[1], "r");

		//Q File
		printf("ey1\n");
		qfile = fopen(qfileName,"w");
		fputs("", qfile);
		fclose(qfile);
		printf("ey2\n");
		qfile = fopen(qfileName,"a");

		init(); //iniciar tabla de símbolos
		dump("t.s. inicial");
		printf("ey3");
		yyparse();			// Actualmente (29/09/22 3:59) se queda pillado en esta línea.
		printf("ey4");
		dump("t.s. final");
		free(init_stack);
	} else {
		//print some help?
		printf("No source file given.\n");
	}
	return 0;
}

int yyerror(char const *s){
	dump("ERROR");
	fprintf(stderr, "error in line %d: %s , %d\n", lines, s, chars);
	//fprintf("yyparse: %d", yyparse());
	fclose(qfile);
}
