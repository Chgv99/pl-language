%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>
#include <errno.h>

#include "table.h" /* tabla de símbolos */

int yylex();
//int yyparse(void);
int yyerror(char const *s);
void gc(char* str);
void createVariable();
void insertIntoVarStack(char*);
extern FILE *yyin;
//extern enum type;
extern int lines;   /* lexico */
extern int chars;	/* lexico */
extern int _scope;   /* lexico */

#define YYDEBUG 1 //debugging

FILE *qfile;
char *qfileName = "output.q.c";

int lineSize;
char* line;

struct node* voidp;

//list<char*> init_stack;
//char** init_stack;

enum type _type;

int _tag;
int _statcode;

const unsigned int _z = 0x12000;
const unsigned int _minStat = 0x08000;

struct variable{
	char* id;
	enum type tipo;
	struct variable *sig;
	struct variable *ant;
} *first, *last;

//int _scope;

void init_s_t() { /* iniciar tabla de símbolos */
	//insertar("", tipo, my_void);
	voidp = top;
	insertar("-", tipo, entero);
	insertar("--", tipo, flotante);
	insertar("---", tipo, booleano);
	insertar("----", tipo, caracter);
}

void init(){
	//init_stack = (char**) malloc(10 * sizeof(char*));
	_scope = 0; // Ámbito Global (flex)
	_tag = 1; 		//0 reservado para comienzo de fichero en código Q
	init_s_t();
}

int tag() {
	return _tag++;
}

/*void deleteScope(){
	while(struct node* var = buscar_scope(_scope)){
		eliminar(var->id)
	}
	_scope--;
}*/

%}

%token INC DEC MULT_ASSIGN DIV_ASSIGN
%token LEARN ARROW RET END NEXT TERM
%token COMM RANGE LEN PRINT
%token METH IF AND OR NOT ELSE LOOP FOR WHILE UNTIL
%token EQ NEQ GT LT GTE LTE
%token TRUE FALSE

// TIPOS

// primitivos
%token <id> NAME
%token <my_int> INT
%token <my_float> FLOAT 
%token <my_bool> BOOL 
%token <my_char> CHAR 
//%token <my_int> ID_VOID //??
//%token <my_int> ID_ARR 
%token <my_str> STR
%token /*<my_void>*/ VOID

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
	int my_type;
	//void my_void;
}

%type<id> nameContainer;

//%type <expr> initialization


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

statement: initialization			{
										//initialize variable
										
									}
| 	initialization '=' expression	{
										//modify existing variable
										struct variable* var = first;
										while (var != NULL){
											var->tipo = $<my_type>1;
											//createVariable(var); //store value on symbol table?
											snprintf(line, lineSize, "\tR\t# Reserva de memoria para %s\n", var->id);	
											gc(line);
											var = var->sig;
										}
										//I(R6 - 4) = R0;	 
										gc("R0 = ");
									}
|   NAME '=' expression  			{	
										//createVariable();
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

initialization: type nameContainer { 
										//Leer stack de variables e inicializar una a una
										struct variable* var = first;
										while (var != NULL){
											var->tipo = $<my_type>1;
											createVariable(var);
											snprintf(line, lineSize, "\tR7 = R7 - 4\t# Reserva de memoria para %s\n", var->id);	
											gc(line);
											//snprintf(line, lineSize, "\tR\t# Reserva de memoria para %s\n", var->id);	
											//gc(line);
											var = var->sig;
										}
										//first = NULL; //mover a regla superior (asignación)
									}
;


nameContainer: NAME			{ insertIntoVarStack($<id>1); } 
|	NAME ',' nameContainer 	{ insertIntoVarStack($<id>1); }
;

param: type NAME
|	type NAME ',' param
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
|		LOOP 				{
								$<my_int>$ = tag(); 
								//snprintf(line, lineSize, "L %d:\n", $<my_int>$);		//L N1:
								gc(line);
							}
		'(' DIGIT ')'		{
								$<my_int>$ = tag(); 
								//snprintf(line, lineSize, "R1 = R0 > 0;\nIF(!R1) GT(%d);\n",$<my_int>$); 	//R1 = R0 > 0; 		condición	
								gc(line);
							}																				//IF (!R1) GT(N2);	condición
		increaseScope		{}
		content 			{/*gc("%s", $7);*/} 															//subárbol
		decreaseScope		{
								//snprintf(line, lineSize, "GT(%d);\n", $<my_int>1);	//GT(N1);
								gc(line);
								//snprintf(line, lineSize, "L %d:\n",$<my_int>3);		//L N2:
								gc(line);
							}
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
								}':' type increaseScope content decreaseScope 	// RETURN isnt forced to be use
//|	METH NAME '('initializations')'':' type'{'content'}'
;

/*type: type { $$ = "1"; }
|	type '[' ']'
|	type '[' DIGIT ']'
|	type '[' NAME ']'
;*/

type: INT 	{ $<my_int>$ = entero; }
|   FLOAT 	{ $<my_int>$ = flotante; }
|   BOOL 	{ $<my_int>$ = booleano; }
|   CHAR 	{ $<my_int>$ = caracter; }
|   STR 	{ $<my_int>$ = ristra; }
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
		//snprintf(line,lineSize, str, val);
		*fmt++;
    }
	va_end(ap);
}*/

void gc(char* str){
	fputs(str, qfile);
}

//params: id, tipo
void createVariable(struct node* var){
	if (buscar(var->id) == NULL){
		if (_scope == 0){
			insertar(var->id, v_global, var->tipo);
			return;
		}
		insertar(var->id, v_local, var->tipo);
	}
	

	// Asignación
	/*struct node* var = buscar($1);
	if (var != NULL){
		printf("variable %s utilizable (line: %d)\n", $1, lines);
	} else printf("variable %s no utilizable (line: %d)\n", $1, lines);*/
}

void insertIntoVarStack(char* id){
	if (first == NULL && last == NULL){
		struct variable *newvar = (struct variable *) malloc(sizeof(struct variable));
		newvar->id = id;
		first = newvar;
		last = newvar;
	} else {
		/*struct variable *var = first;
		while (var->sig != NULL){
			//printf("secondary variable loop for %s: %s", id, var->id);
			var = var->sig;
		}
		//printf("\n");
		struct variable *newvar = (struct variable *) malloc(sizeof(struct variable));
		newvar->id = id;
		var->sig = newvar;*/

		//---
		struct variable *var = last;
		struct variable *newvar = (struct variable *) malloc(sizeof(struct variable));
		newvar->id = id;
		last->sig = newvar;
		last = newvar;
	}
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
	errno = 0;
	if (argc != 2){
		//print some help
		errno = 1;
		perror("No source file given");
		exit(1);
	}
	//Source file
	yyin = fopen(argv[1], "r");
	if (yyin == NULL) {
		errno = 2;
		perror("Failed to open source file");
		exit(1);
	}
	//Q File
	qfile = fopen(qfileName,"w");
	if (qfile == NULL) {
		errno = 2;
		perror("Failed to open Q file");
		exit(1);
	}
	fputs("", qfile);
	fclose(qfile);
	qfile = fopen(qfileName,"a");
	if (qfile == NULL) {
		errno = 2;
		perror("Failed to open Q file");
		exit(1);
	}

	yydebug = 0; //1 = enabled

	lineSize = sizeof(char*) * 500;
	line = (char*) malloc(lineSize);


	//R7 = 0x08000;// Reservamos espacio en la memoria estática
	//R6 = R7;

	gc("#include \"Q.h\"\n");
	gc("BEGIN\n");
	gc("L 0:\t\t\t\t\t\t# Inicio del programa\n");
	//snprintf(line, lineSize, "STAT(%d)\n", _statcode);
	gc(line);
	gc("\t# Memoria estática\n");
	snprintf(line, lineSize, "CODE(%d)\n", _statcode++);
	gc(line);
	snprintf(line, lineSize, "\tR7 = 0x%05X\n", _minStat);
	gc(line);
	snprintf(line, lineSize, "\tR6 = R7\n");
	gc(line);

	init(); //iniciar tabla de símbolos
	dump("t.s. inicial");
	yyparse();
	dump("t.s. final");
	gc("END\n");
	fclose(qfile); //core dump
	fclose(yyin);

	free(line);
	return 0;
}

int yyerror(char const *s){
	dump("ERROR");
	fprintf(stderr, "error in line %d: %s , %d\n", lines, s, chars);
	//fprintf("yyparse: %d", yyparse());
	fclose(qfile);
}
