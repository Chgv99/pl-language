%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>
#include <errno.h>
#include <limits.h>
#include <unistd.h>

#include "table.h" /* tabla de símbolos */

int yylex();
//int yyparse(void);
int yyerror(char const*);

//struct with the type and reg of the variable
struct varPack{
	char* varId;
	int varType;
	int varReg;
	int varCat;

	//En pruebas
	int 	val_int;
	float 	val_float;
	char 	val_char;
	char* 	val_str;
	bool 	val_bool;
};

int registers_I[8];
int registers_F[4];

void gc(char*);

void createVariable();
void declareVar(char*);

void initializeVar(struct varPack*);
void packInitializer(char*, struct varPack*);

struct varPack * arithmetical(struct varPack*, char, struct varPack*);
struct varPack * logical(struct varPack*, char, struct varPack*);

void lib_reg(struct varPack*);
int assign_reg();

struct varPack * storeOperand(struct varPack*);

void printStr(char* str);
void print(char* id);
//void print(struct varPack*);
//void insertIntoVarStack(char*);
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

enum type _type = -1;

const unsigned int _z = 0x12000;
unsigned int z;
int _globalgap = 0;
int _localgap = 0;
int _localdir = 1;	//points to local variable
const unsigned int _minStat = 0x08000;

const int _MaxMultipleDeclaration = 30;
//int *_varDecl = (int) malloc(_MaxMultipleDeclaration * sizeof(int));
int _value;

/*struct variable{
	char* id;
	enum type tipo;
	struct variable *sig;
	struct variable *ant;
} *first, *last;*/

//int _scope;

void init_s_t() { /* iniciar tabla de símbolos */
	//insertar("", tipo, my_void);
	voidp = top;
	insertar("-", tipo, entero, 0);
	insertar("--", tipo, flotante, 0);
	insertar("---", tipo, booleano, 0);
	insertar("----", tipo, caracter, 0);
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
%token <my_str> TRUE FALSE

// TIPOS

// primitivos
%token <id> NAME
%token <my_int> INT 		//literales de tipo no deberían tener tipo (?)
%token <my_float> FLOAT 	//literales de tipo no deberían tener tipo (?)
%token <my_bool> BOOL 		//literales de tipo no deberían tener tipo (?)
%token <my_char> CHAR 		//literales de tipo no deberían tener tipo (?)
%token STR 		//literales de tipo no deberían tener tipo (?)
//%token <my_int> ID_VOID //??
//%token <my_int> ID_ARR 
%token <my_str> V_STR
%token /*<my_void>*/ VOID

%token <my_int> DIGIT

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
	int* my_int_bundle;
	struct varPack* my_pack;
}

%type<my_int> nameContainer; //returns number of vars created at once
%type<my_pack> expression; //TODO: cualquier tipo (?)
%type<my_pack> expressionArithmetical; //TODO: cualquier tipo (?)
%type<my_pack> expressionLogical; //TODO: cualquier tipo (?)
//%type<my_pack> operand;		//my_pack may be replace with a pointer to my_pack?
%type<my_pack> operandArithmetical;
%type<my_pack> operandLogical;
%type<id> initialization


%right '=' INC DEC MULT_ASSIGN DIV_ASSIGN
//lógicas primero or luego and
//equals
//comparativas
%left '+' '-'
%left '*' '/' '%' //Comprobar si módulo va aquí
%left '^' //Feeling cute, may delete later
//not

%start program //cambiar a statementS?

%%

program: /* empty */ { printf("Empty input\n"); }
|	import program
|	content;

import: LEARN ARROW STR
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
										printf("isolated init: %d\n", lines);
										_value = 0;
									}
| 	initialization '=' expression	{
										packInitializer($<id>1, $<my_pack>3);
									}
|   NAME '=' expression  			{
										packInitializer($<id>1, $<my_pack>3);										
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

initialization: type 			{ 
									_type = $<my_type>1; 
								} 
				nameContainer	{ 
										$<id>$ = $<id>3;
										//printf("init\n");
										//printf("_z(d) - r7gap = %d\n", _z - r7gap);
										//printf("_z(0x) - r7gap = %05x\n", _z - r7gap);
								}
;


nameContainer: NAME 							{
													declareVar($<id>1);	
													$$ = $<id>1;
												}
|	NAME ',' nameContainer 						{ 
													declareVar($<id>1);
													
												}//insertIntoVarStack($<id>1); }
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

expression: expressionArithmetical	{$$ = $<my_pack>1;}
|	expressionLogical				{$$ = $<my_pack>1;}
;

expressionArithmetical: operandArithmetical			{ if ($1->varCat){ $$ = storeOperand($1);}; }
|	expressionArithmetical '+' expressionArithmetical  { $$ = arithmetical($1,'+',$3); }
|	expressionArithmetical '-' expressionArithmetical	{ $$ = arithmetical($1,'-',$3); }
|	expressionArithmetical '*' expressionArithmetical	{ $$ = arithmetical($1,'*',$3); }
|	expressionArithmetical '/' expressionArithmetical	{ $$ = arithmetical($1,'/',$3); }
|	expressionArithmetical '%' expressionArithmetical	{ $$ = arithmetical($1,'%',$3); }
|	expressionArithmetical '^' expressionArithmetical	{ $$ = arithmetical($1,'^',$3); } //deleteable
|	len
//|	'{' list '}'
;

expressionLogical: operandLogical			{ if ($1->varCat){ $$ = storeOperand($1);}; }
|	expressionLogical AND expressionLogical  { $$ = logical($1,'&',$3); }
|	expressionLogical OR expressionLogical	{ $$ = logical($1,'|',$3); }
|	NOT expressionLogical	{ $$ = logical($2,'!',$2); }
;

expressionArray: '{' digitContainer '}'
;

operandArithmetical: DIGIT 	{
							struct varPack *pack =  malloc(sizeof(struct varPack));
							pack->varReg = assign_reg();
							pack->varType = 1; //int
							pack->val_int = $1;
							pack->varCat = 1;
							$<my_pack>$ = pack;
							}
|	NAME 					{
							struct node* var = buscar($<id>1);

							struct varPack *pack =  malloc(sizeof(struct varPack));
							
							pack->varReg = assign_reg();
							pack->varType = var->tipo; //should check if its an Int
							

							if(var->cat == v_global){
								snprintf(line, lineSize, "\tR%d = I(0x%05x);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
								gc(line);
							}else if(var->cat == v_local){
								snprintf(line, lineSize, "\tR%d = I(R6 - %d);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
								gc(line);
							}
							
							//pack->val_int = $1;
							pack->varCat = 0;

							$<my_pack>$ = pack;
							}
//|	NAME '[' DIGIT ']'
//|	NAME '[' NAME ']' //multidimensionales?
|	NAME '(' paramContainer ')' //function call
;

operandLogical: TRUE 	{
						struct varPack *pack =  malloc(sizeof(struct varPack));
						pack->varReg = assign_reg();
						pack->varType = 3; //bool
						pack->val_bool = true;
						pack->varCat = 1;
						$<my_pack>$ = pack;
						}
|	FALSE 				{
						struct varPack *pack =  malloc(sizeof(struct varPack));
						pack->varReg = assign_reg();
						pack->varType = 3; //bool
						pack->val_bool = false;
						pack->varCat = 1;
						$<my_pack>$ = pack;
						}
|	NAME 				{
						struct node* var = buscar($<id>1);

						struct varPack *pack =  malloc(sizeof(struct varPack));
						
						pack->varReg = assign_reg();
						pack->varType = var->tipo; //should check if its an bool
						

						if(var->cat == v_global){
							snprintf(line, lineSize, "\tR%d = I(0x%05x);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
							gc(line);
						}else if(var->cat == v_local){
							snprintf(line, lineSize, "\tR%d = I(R6 - %d);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
							gc(line);
						}
						
						//pack->val_int = $1;
						pack->varCat = 0;

						$<my_pack>$ = pack;
						}
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


controlStructure: IF '(' expressionLogical ')' 	{
													$<my_int>$ = checkCondition($3);
												} 
increaseScope content decreaseScope 
							{
								snprintf(line, lineSize, "\t//if content\n//end if()\nL %d: \n", $<my_int>5);
								gc(line);
							}
|		LOOP 				{
								$<my_int>$ = tag(); 
								//snprintf(line, lineSize, "L %d:\n", $<my_int>$);		//L N1:
								gc(line);
							}
		'(' DIGIT ')'		{//may implement to be able to use varibles
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
|	LOOP WHILE '(' expressionLogical ')' increaseScope content decreaseScope
|	LOOP UNTIL '(' expressionLogical ')' increaseScope content decreaseScope
;

increaseScope: '{' 	{ _scope++; };

decreaseScope: '}' 	{ 	eliminar_scope(_scope);
						_scope--;
					};

len: LEN '(' NAME ')'
;

print: PRINT '(' V_STR ')'		{
									char* str = $3;
									int strLength = strlen(str);
									int j = 0;
									for (int i = 0; i < strLength; i ++) {
									            if (str[i] != '"' && str[i] != '\\') { 
									                 str[j++] = str[i];
									            } else if (str[i+1] == '"' && str[i] == '\\') { 
									                 str[j++] = '"';
									            } else if (line[i+1] != '"' && str[i] == '\\') { 
									                 str[j++] = '\\';
									            }
									}
									if(j>0) str[j]=0;

									snprintf(line,lineSize, "//printing a STR: %s\n", str); // R1 = 0x... STR dir
									gc(line);
									printStr(str);
									/**struct varPack *pack =  malloc(sizeof(struct varPack));
									pack->varReg = assign_reg();
									pack->varType = ristra;
									pack->val_str = $3;*/
									
									//storeOperand(pack);
									//printStr(pack);
									//lib_reg(pack);
								}
|	PRINT '(' expression ')' 	{

								}
|	PRINT '(' NAME ')' 	{ 
							snprintf(line,lineSize, "//printing an ID: %s\n", $3); // R1 = 0x... STR dir
							gc(line);
							//struct varPack *pack =  malloc(sizeof(struct varPack));
							//pack->varId = $<id>3;
							//pack->varReg = 
							//gc("//printing an ID\n");
							print($<id>3);
						}
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
			insertar(var->id, v_global, var->tipo, 0);
			return;
		}
		insertar(var->id, v_local, var->tipo, 0);
	}
	

	// Asignación
	/*struct node* var = buscar($1);
	if (var != NULL){
		printf("variable %s utilizable (line: %d)\n", $1, lines);
	} else printf("variable %s no utilizable (line: %d)\n", $1, lines);*/
}

void initializeVar(struct varPack *pack){
	struct node* var = buscar(pack->varId);
	if (var == NULL){
		printf("Variable %s no encontrada", var->id);
		return;
	}

	if (pack->varType != _type){
		printf("Types mismatch, expected %d but got %d", pack->varType, _type);
		return;
	}

	//gc("//initializeVar\n");
	printf("initializeVar for %d", pack->varType);
	if (var->cat == v_global){
		/*snprintf(line,lineSize, "\tR%d = 0x%05x;\t\t//Generated by line %d\n", r0, var->dir, lines); // 
		gc(line);*/
		snprintf(line,lineSize, "// pack->varType = %d, initializeVar%d\n", pack->varType, lines); // 
		gc(line);
		switch(pack->varType){
			case entero:
				/*snprintf(line, lineSize, "\tR%d = %d;\t\t//Generated by initializeVar at line %d\n", pack->varReg, pack->val_int, lines); 
				gc(line);*/
				snprintf(line, lineSize, "\tI(0x%05x) = R%d;\t\t//Generated by line %d\n", var->dir, pack->varReg, lines); 
				gc(line);
				break;
			case flotante:
				snprintf(line, lineSize, "\tR0 = %f;\t\t//Generated by line %d\n", pack->val_float, lines); 
				gc(line);
				break;
			case booleano:
				snprintf(line, lineSize, "\tI(0x%05x) = R%d;\t\t//Generated by line %d\n", var->dir, pack->varReg, lines); 
				gc(line);
				break;
		}
		
	} else if (var->cat == v_local){
		snprintf(line, lineSize, "\tI(R6 - %d) = R%d;\t\t//Generated by line %d\n", var->dir, pack->varReg, lines); 
		gc(line);
		/*snprintf(line, lineSize, "\tR0 = %d;\t\t//Generated by line %d\n", _value, lines); 
		gc(line);
		snprintf(line, lineSize, "\tI(R6 - %d) = R0;\t\t//Generated by line %d\n", var->dir, lines); 
		gc(line);*/
	} else {
		printf("var null");
	}
	lib_reg(pack);
}

void declareVar(char* id){
	if (_scope == 0) {
		_globalgap++;
		unsigned int dir = z - _globalgap * 4;
		snprintf(line,lineSize, "STAT(%d)\t\t//Generated by line %d\n", _statcode, lines);
		gc(line);
		snprintf(line,lineSize, "\tDAT(0x%05x,I,0);\t\t//Generated by line %d\n", dir, lines); // 
		gc(line);
		
		snprintf(line,lineSize, "//id: %s\n", id); // 
		gc(line);

		snprintf(line,lineSize, "CODE(%d)\t\t//Generated by declareVar at line %d\n", _statcode++, lines); // 
		gc(line);

		insertar(id, v_global, _type, _z - 4*_globalgap);
	} else {
		_localgap++;
		snprintf(line, lineSize, "\tR7 = R7 - 4;\t\t// E Generated by line %d\n", lines);
		gc(line);
		insertar(id, v_local, _type, 4*_localdir++);
	}
	_value = 0;
}

void printStr(char* str){
	int retTag = tag();
	_globalgap++;
	unsigned int strDir = _z - _globalgap++ * 4 * strlen(str);
	snprintf(line, lineSize, "STAT(%d)\t//Generated by print\n", _statcode);		//STAT(i);
	gc(line);
	snprintf(line,lineSize, "\tSTR(0x%05x,\"%s\\n\");\t\t//Generated by line %d\n", strDir, str, lines); // 
	gc(line);
	snprintf(line, lineSize, "CODE(%d)\t//Generated by print\n", _statcode++);		//CODE(dir,"%c");
	gc(line);

	//// Guardar el contenido de los registros r0, r1, r2
	{
		snprintf(line, lineSize, "\tI(R7 - 4) = R0;\t//Generated by print at line: %d\n", lines);	//I(R7) = R0;
		gc(line);
		snprintf(line, lineSize, "\tI(R7 - 8) = R1;\t//Generated by print at line: %d\n", lines);	//I(R7 - 4) = R1;
		gc(line);
		snprintf(line, lineSize, "\tI(R7 - 12) = R2;\t//Generated by print at line: %d\n", lines);	//I(R7 - 8) = R2;
		gc(line);
		snprintf(line, lineSize, "\tR7 = R7 - 16;\t//Generated by print at line: %d\n", lines);	//R7 = R7 - 12;
		gc(line);
	}
	////
	snprintf(line,lineSize, "\tR0 = %d;\t\t//Generated by line %d\n", retTag, lines); // R1 = 0x... STR dir
	gc(line);
	snprintf(line,lineSize, "\tR1 = 0x%05x;\t\t//Generated by line %d\n", strDir, lines); // R1 = 0x... STR dir
	gc(line);
	snprintf(line,lineSize, "\tR2 = 0;\t\t//Generated by line %d\n", lines); // R1 = 0x... STR dir
	gc(line);
	gc("\tGT(-12);\t//Generated by print\n");
	snprintf(line, lineSize, "L %d:\n", retTag);
	gc(line);
	//// Cargar el contenido guardado en los registros r0, r1, r2
	{
		snprintf(line, lineSize, "\tR0 = I(R7 + 12);\t//Generated by print at line: %d\n", lines);	//I(R7) = R0;
		gc(line);
		snprintf(line, lineSize, "\tR1 = I(R7 + 8);\t//Generated by print at line: %d\n", lines);	//I(R7 - 4) = R1;
		gc(line);
		snprintf(line, lineSize, "\tR2 = I(R7 + 4);\t//Generated by print at line: %d\n", lines);	//I(R7 - 8) = R2;
		gc(line);
	}
	////
}

void print(char* id){
	struct node* var = buscar(id);

	//// Guardar el contenido de los registros r0, r1, r2
	snprintf(line, lineSize, "\tI(R7 - 4) = R0;\t//Generated by print at line: %d\n", lines);	//I(R7) = R0;
	gc(line);
	snprintf(line, lineSize, "\tI(R7 - 8) = R1;\t//Generated by print at line: %d\n", lines);	//I(R7 - 4) = R1;
	gc(line);
	snprintf(line, lineSize, "\tI(R7 - 12) = R2;\t//Generated by print at line: %d\n", lines);	//I(R7 - 8) = R2;
	gc(line);
	snprintf(line, lineSize, "\tR7 = R7 - 16;\t//Generated by print at line: %d\n", lines);	//R7 = R7 - 12;
	gc(line);
	////

	if (var->dir != 0){
		_globalgap++;
		int retTag = tag();

		unsigned int strDir = _z - _globalgap++ * 4; //_z - 4*_globalgap;
		
		snprintf(line, lineSize, "\tR0 = %d;\t//Generated by print at line: %d\n", retTag, lines);		//R0 = TAG; //TAG de regreso
		gc(line);
		if (var->cat == v_global){
			snprintf(line, lineSize, "\tR2 = I(0x%05x);\t//Generated by print\n", var->dir);		//R2 = I(dir);
		}
		else if (var->cat == v_local){
			snprintf(line, lineSize, "\tR2 = I(R6 - %d);\t//Generated by print\n", var->dir);		//R2 = I(dir);
			
		}
		gc(line);
		snprintf(line, lineSize, "STAT(%d)\t//Generated by print\n", _statcode);		//STAT(i);
		gc(line);
		snprintf(line, lineSize, "\tSTR(0x%05x, \"%%i\\n\");\t//Generated by print\n", strDir);		//STR(dir,"%i");
		gc(line);
		snprintf(line, lineSize, "CODE(%d)\t//Generated by print\n", _statcode++);		//CODE(dir,"%c");
		gc(line);
		snprintf(line, lineSize, "\tR1 = 0x%05x;\t//Generated by print\n", strDir);		//R1 = dir;
		gc(line);
		snprintf(line, lineSize, "\tR0 = %d;\t//Generated by print\n", retTag);		//R0 = 12; //TODO: Comprobar
		gc(line);
		gc("\tGT(-12);\t//Generated by print\n");
		snprintf(line, lineSize, "L %d:\n", retTag);
		gc(line);
	} else {
		//gc("tryin to print local variable huh\n");
	}

	//// Cargar el contenido guardado en los registros r0, r1, r2
	snprintf(line, lineSize, "\tR0 = I(R7 + 12);\t//Generated by print at line: %d\n", lines);	//I(R7) = R0;
	gc(line);
	snprintf(line, lineSize, "\tR1 = I(R7 + 8);\t//Generated by print at line: %d\n", lines);	//I(R7 - 4) = R1;
	gc(line);
	snprintf(line, lineSize, "\tR2 = I(R7 + 4);\t//Generated by print at line: %d\n", lines);	//I(R7 - 8) = R2;
	gc(line);
	////
}

struct varPack * storeOperand(struct varPack* op){
	//TODO: Diferenciar tipos
	char *comment = malloc(lineSize);
	snprintf(comment,lineSize,"\t\t\t// StoreOperand at line:%d",lines);
	switch(op->varType){
		case entero:
			snprintf(line,lineSize, "\tR%d = %d;%s\n",op->varReg,op->val_int, comment);
			break;
		case booleano:
			snprintf(line,lineSize, "\tR%d = %d;%s\n",op->varReg,op->val_bool, comment);
			break;
		case ristra:
			snprintf(line,lineSize, "\tR%d = \"%s\";%s\n",op->varReg,op->val_str, comment);
			break;
		default:
			snprintf(line,lineSize, "// storeOperand error\n");
			break;
	}
	gc(line);
	return op;
}


struct varPack * arithmetical(struct varPack* op1, char sign, struct varPack* op2){
	struct varPack* result;
	char *comment = malloc(lineSize);
	snprintf(comment,lineSize,"\t\t\t// Arithmetical - l:%d",lines);

	if ((op1->varType == 4 || op1->varType == 1) && 
			(op2->varType == 4 || op2->varType ==  1)){
		snprintf(line,lineSize, "\tR%d=R%d%cR%d;%s\n",op1->varReg,op1->varReg,sign,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
	}else if(op1->varType == 2 && op2->varType == 2){
		snprintf(line,lineSize, "\tRR%d=RR%d%cRR%d;%s\n",op1->varReg,op1->varReg,sign,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
	}else if(op1->varType == 2 && op2->varType == 1){
		snprintf(line,lineSize, "\tRR%d=RR%d%cR%d;%s\n",op1->varReg,op1->varReg,sign,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
	}else if(op1->varType == 1 && op2->varType == 2){
		snprintf(line,lineSize, "\tRR%d=R%d%cRR%d;%s\n",op2->varReg,op1->varReg,sign,op2->varReg, comment);
		lib_reg(op1);
		result = op2;
	}else{
		yyerror("Wrong variable type used");
	}
	gc(line);
	free(comment);
	return result;		
}

struct varPack * logical(struct varPack* op1, char sign, struct varPack* op2){
	struct varPack* result;
	char *comment = malloc(lineSize);
	snprintf(comment,lineSize,"\t\t\t// Logical - l:%d",lines);

	if(op1->varType == 3 && op2->varType == 3){
		if(sign == '!'){
			snprintf(line,lineSize, "\tR%d=%cR%d;%s\n",op1->varReg,sign,op1->varReg, comment);
			result = op1;
		}else{
			snprintf(line,lineSize, "\tR%d=R%d%c%cR%d;%s\n",op1->varReg,op1->varReg,sign,sign,op2->varReg, comment);
			lib_reg(op2);
			result = op1;
		}
	}else{
		yyerror("Wrong variable type used");
	}
	gc(line);
	free(comment);
	return result;		
}

void checkCondition(struct varPack * pack){
	int retTag = tag();
	snprintf(line, lineSize, "//checkCondition()\n");
	gc(line);
	snprintf(line, lineSize, "\tR%d = R%d == 1;\n", pack->varReg, pack->varReg);
	gc(line);
	snprintf(line, lineSize, "\tIF (!R%d) GT(%d);\n", pack->varReg, retTag);
	gc(line);
	return retTag;
}

void packInitializer(char* id, struct varPack *expression){
	struct varPack *pack = malloc(sizeof(struct varPack));
	pack->varId = id; 
	pack->varReg = expression->varReg;
	pack->varType = expression->varType;										
	
	initializeVar(pack);
}

int assign_reg(){
	/*for(int i = 0; i < 8; i++){
		printf("[%d,", registers_I[i]);
	}
	printf("]\n");*/

	int len;
	if (_type == flotante){
		len = sizeof(registers_F)/sizeof(registers_I[0]);
		for (int i = 0; i < len; i++){
			if (!registers_F[i]){
				registers_F[i] = true;
				return i;
				break;
			}
		}
		yyerror("Fallo de compilador, sin registros comaFlotante");
	}else{
		len = sizeof(registers_I)/sizeof(registers_I[0]);
		for (int i = 0; i < len; i++){
			if (!registers_I[i]){
				registers_I[i] = true;
				return i;
				break;
			}
		}
		yyerror("Fallo de compilador, sin registros entero");
	}

}

void lib_reg_num(int reg){

}

void lib_reg(struct varPack* reg){
	int len;
	if (reg->varType == flotante){
		len = sizeof(registers_F)/sizeof(registers_I[0]);
		if (len <= reg->varReg){
			snprintf(line,lineSize,"Fallo de compilador, el registro comaFlotante %d no está disponible, máximo %d",reg->varReg, len);
			yyerror(line);
		}
		registers_F[reg->varReg] = false;
	}else{
		len = sizeof(registers_I)/sizeof(registers_I[0]);
		if (len <= reg->varReg){
			snprintf(line,lineSize,"Fallo de compilador, el registro entero %d no está disponible, máximo %d", reg->varReg, len);
			yyerror(line);
		}
		registers_I[reg->varReg] = false;
	}
	free(reg);
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

	/*if (access(fname, F_OK) != 0) {
	    // file doesn't exist

	}*/

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

	z = _z; //sets z to 0x12000

	//R7 = 0x08000;// Reservamos espacio en la memoria estática
	//R6 = R7;

	gc("#include \"Q.h\"\n");
	gc("BEGIN\n");
	gc("L 0:\t\t\t\t\t\t// Inicio del programa\n");
	snprintf(line, lineSize, "STAT(%d)\t// Memoria estática\n", _statcode);
	gc(line);
	//gc("\t# Memoria estática\n");
	snprintf(line, lineSize, "CODE(%d)\n", _statcode++);
	gc(line);
	snprintf(line, lineSize, "\tR7 = R7 - 4;\n");
	gc(line);
	snprintf(line, lineSize, "\tR6 = R7;\n");
	gc(line);

	init(); //iniciar tabla de símbolos
	dump("t.s. inicial");
	yyparse();
	dump("t.s. final");
	gc("GT(-2);\n");
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
