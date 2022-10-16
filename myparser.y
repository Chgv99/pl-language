%{
#include <stdio.h>
#include <stdlib.h>
#include <stdbool.h>
#include <stdarg.h>
#include <errno.h>
#include <limits.h>
#include <unistd.h>
#include <string.h>

#include "table.h" /* symbol table */

int yylex();
//int yyparse(void);
int yyerror(char const*);

//struct with the type and reg of the variable
struct varPack{
	char* varId;
	int varType;
	int varReg;
	int varCat;	//0: variable; 1: number.
	int val_int;
	float val_float;
	char val_char;
	char* val_str;
	bool val_bool;
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
struct varPack * relational(struct varPack*, char, struct varPack*);

void methReturn();
int checkCondition(struct varPack*);

void lib_reg_num(int, int);
void lib_reg(struct varPack*);
int assign_reg_num(int, int);
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

enum type _type;

int _tag;
int _statcode;

int _routineParamCounter = 0;

enum type _type = -1;

const unsigned int _z = 0x12000;
unsigned int z;
int _globalgap = 0;
int _localgap = 0;
int _localdir = 1;	//points to local variable
int _ldanchor = 0;
const unsigned int _minStat = 0x08000;

const int _MaxMultipleDeclaration = 30;
int _value;

int _insideMeth = 0;

void init_s_t() { /* iniciar tabla de símbolos */
	voidp = top;
	insertar("-", tipo, entero, 0);
	insertar("--", tipo, flotante, 0);
	insertar("---", tipo, booleano, 0);
	insertar("----", tipo, caracter, 0);
}

void init(){
	_scope = 0; // Ámbito Global (flex)
	_tag = 1; 		//0 reservado para comienzo de fichero en código Q
	init_s_t();
}

int tag() {
	return _tag++;
}

unsigned int _DIR;


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
%token <my_int> INT 		
%token <my_float> FLOAT 	
%token <my_bool> BOOL 		
%token <my_char> CHAR 		
%token STR 		
%token <my_str> V_STR
%token VOID

%token <my_int> DIGIT
%token <my_float> FDIGIT
%token <my_char> CARACTER

%union{
	char* id;

	int my_int;
	float my_float;
	bool my_bool;
	char my_char;
	// Compuestos
	char* my_str;
	int my_type;
	struct varPack* my_pack;
}

%type<my_int> nameContainer; //returns number of vars created at once
%type<my_pack> expression; 
%type<my_pack> expressionArithmetical; 
%type<my_pack> expressionLogical; 
%type<my_pack> expressionRelational; 
%type<my_pack> operandArithmetical;
%type<my_pack> operandLogical;
%type<my_pack> operandRelational;
%type<id> initialization


%right '=' INC DEC MULT_ASSIGN DIV_ASSIGN
%left '+' '-'
%left '*' '/' '%' 
%left '^'

%start program

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
|	methodCall						//only one methodCall
|	content methodCall				//multiple methodCalls
;

statement: initialization			{
										printf("isolated init: %d\n", lines);
										_value = 0;
									}
| 	initialization '=' expression	{
										packInitializer($<id>1, $<my_pack>3);
									}
|   NAME '=' expression  			{
										packInitializer($<id>1, $<my_pack>3);										
									}
|	END 
|	NEXT
|	TERM
|	print
|	return  							{	if (!_insideMeth) yyerror("unexpected return statement");	}
;

initialization: type 			{ 
									_type = $<my_type>1; 
								} 
				nameContainer	{ 
									$<id>$ = $<id>3;
								}
;

nameContainer: NAME 							{
													declareVar($<id>1);	
													$<id>$ = $<id>1;
												}
|	NAME ',' nameContainer 						{ 
													declareVar($<id>1);
													
												}
;

expression: expressionArithmetical	{ $$ = $<my_pack>1; }
|	expressionLogical				{ $$ = $<my_pack>1; }
|	expressionRelational			{ $$ = $<my_pack>1; }
;

expressionArithmetical: operandArithmetical				{ if ($1->varCat){ $$ = storeOperand($1);}; }
|	expressionArithmetical '+' expressionArithmetical  	{ $$ = arithmetical($1,'+',$3); }
|	expressionArithmetical '-' expressionArithmetical	{ $$ = arithmetical($1,'-',$3); }
|	expressionArithmetical '*' expressionArithmetical	{ $$ = arithmetical($1,'*',$3); }
|	expressionArithmetical '/' expressionArithmetical	{ $$ = arithmetical($1,'/',$3); }
|	expressionArithmetical '%' expressionArithmetical	{ $$ = arithmetical($1,'%',$3); }
|	expressionArithmetical '^' expressionArithmetical	{ $$ = arithmetical($1,'^',$3); }
;

expressionLogical: operandLogical			{ if ($1->varCat){ $$ = storeOperand($1);}; }
|	expressionLogical AND expressionLogical { $$ = logical($1,'&',$3); }
|	expressionLogical OR expressionLogical	{ $$ = logical($1,'|',$3); }
|	NOT expressionLogical					{ $$ = logical($2,'!',$2); }
;

expressionRelational: operandRelational				{ if ($1->varCat){ $$ = storeOperand($1);}; }
|	expressionRelational EQ expressionRelational  	{ $$ = relational($1,'e',$3); }
|	expressionRelational NEQ expressionRelational	{ $$ = relational($1,'n',$3); }
|	expressionRelational '<' expressionRelational	{ $$ = relational($1,'<',$3); }
|	expressionRelational '>' expressionRelational	{ $$ = relational($1,'>',$3); }
|	expressionRelational GTE expressionRelational	{ $$ = relational($1,'g',$3); }
|	expressionRelational LTE expressionRelational	{ $$ = relational($1,'l',$3); }
;

operandArithmetical: DIGIT 	{
								struct varPack *pack =  malloc(sizeof(struct varPack));
								pack->varReg = assign_reg();
								pack->varType = 1; //int
								pack->val_int = $1;
								pack->varCat = 1;
								$<my_pack>$ = pack;
							}
|	FDIGIT 	{
								struct varPack *pack =  malloc(sizeof(struct varPack));
								pack->varReg = assign_reg();
								pack->varType = 2; //float
								pack->val_float = $1;
								pack->varCat = 1;
								$<my_pack>$ = pack;
							}
|	NAME 					{
								struct node* var = buscar($<id>1);

								struct varPack *pack =  malloc(sizeof(struct varPack));
								
								pack->varReg = assign_reg();
								pack->varType = var->tipo;
								
								if(pack->varType == flotante){
									if(var->cat == v_global){
										snprintf(line, lineSize, "\tRR%d = F(0x%05x);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
										gc(line);
									}else if(var->cat == v_local){
										snprintf(line, lineSize, "\tRR%d = F(R6 - %d);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
										gc(line);
									}
								}else{
									if(var->cat == v_global){
										snprintf(line, lineSize, "\tR%d = I(0x%05x);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
										gc(line);
									}else if(var->cat == v_local){
										snprintf(line, lineSize, "\tR%d = I(R6 - %d);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
										gc(line);
									}
								}
								
								
								pack->varCat = 0;

								$<my_pack>$ = pack;
							}
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
							pack->varType = var->tipo;
							

							if(var->cat == v_global){
								snprintf(line, lineSize, "\tR%d = I(0x%05x);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
								gc(line);
							}else if(var->cat == v_local){
								snprintf(line, lineSize, "\tR%d = I(R6 - %d);\t//Generated by NAME at line: %d\n", pack->varReg, var->dir, lines);
								gc(line);
							}
							
							pack->varCat = 0;

							$<my_pack>$ = pack;
						}
;

operandRelational: 	CARACTER 			{
										struct varPack *pack =  malloc(sizeof(struct varPack));
										pack->varType = 4; //char
										pack->val_char = $1;
										pack->varCat = 1;
										pack->varReg = assign_reg();
										$<my_pack>$ = pack;
									}
|	expressionLogical 	{
										struct varPack *pack =  malloc(sizeof(struct varPack));
										pack->varType = $<my_pack>1->varType; //bool
										pack->val_bool = $<my_pack>1->val_bool;
										pack->varCat = $<my_pack>1->varCat;
										pack->varReg = $<my_pack>1->varReg;
										$<my_pack>$ = pack;
									}
|	expressionArithmetical 			{
										struct varPack *pack =  malloc(sizeof(struct varPack));
										pack->varType = $<my_pack>1->varType; //int
										pack->val_int = $<my_pack>1->val_int;
										pack->varCat = $<my_pack>1->varCat;
										pack->varReg = $<my_pack>1->varReg;
										$<my_pack>$ = pack;
									}
;

paramContainer: type NAME 	{
								printf("inside paramContainer");
								_routineParamCounter++;
								declareVar($<id>1);
								//struct node * var = buscar($<id>1);
								//snprintf(line, lineSize, "\tI(R6 - %d)\n", var->dir*4);
								//gc(line);
							}
|	NAME ',' paramContainer
;

controlStructure:	IF '(' expressionRelational ')' {
														$<my_int>$ = checkCondition($3);
														lib_reg($3);
													} 
increaseScope content decreaseScope 
							{
								snprintf(line, lineSize, "\t//if content\n//end if()\nL %d: \n", $<my_int>5);
								gc(line);
							}
|						IF '(' expressionLogical')' {
														$<my_int>$ = checkCondition($3);
														lib_reg($3);
													} 
increaseScope content decreaseScope 
							{
								snprintf(line, lineSize, "\t//if content\n//end if()\nL %d: \n", $<my_int>5);
								gc(line);
							}
|		LOOP 				{
								$<my_int>$ = tag();
							}
		'(' DIGIT ')'		{//may implement to be able to use varibles
								//R4 se destina para el número de iteraciones restantes
								$<my_int>$ = 4*_localdir++;
								snprintf(line, lineSize, "\tR4 = %d; //Storing LOOP amount\n", $<my_int>4);		
								gc(line);		
								snprintf(line, lineSize, "\tI(R6 - %d) = R4;\n", $<my_int>$);		
								gc(line);
							}																				
		increaseScope		{
								$<my_int>$ = tag();
								int reg = assign_reg();
								snprintf(line, lineSize, "L %d:\n", $<my_int>2);		//L N1:
								gc(line);
								snprintf(line, lineSize, "\tR4 = I(R6 - %d);\n", $<my_int>6);		
								gc(line);
								//asdf
								int comp = assign_reg();
								snprintf(line, lineSize, "\tR%d = R4 > 0;\n", comp);
								gc(line);
								snprintf(line, lineSize, "\tIF (!R%d) GT(%d);\n", comp, $<my_int>$);
								gc(line);
								snprintf(line, lineSize, "\tR4 = R4 - 1;\n");
								gc(line);
								/*snprintf(line, lineSize, "\tR%d = R%d - %d;\n", reg, reg, 1);		
								gc(line);*/

								snprintf(line, lineSize, "\tR7 = R7 - 4;\n");		
								gc(line);
								snprintf(line, lineSize, "\tI(R6 - %d) = R4;\n", $<my_int>6);		
								gc(line);
								//insertar();
							}
		content 			{/*gc("%s", $7);*/} 															//subárbol
		decreaseScope		{
								/**snprintf(line, lineSize, "\tI(R6 + %d) = R%d;\n", , reg, 1);		
								gc(line);
								snprintf(line, lineSize, "\tR7 = R7 + 4;\n", reg, reg, 1);		
								gc(line);*/
								snprintf(line, lineSize, "\tGT(%d);\n", $<my_int>2);		//L N1:
								gc(line);
								snprintf(line, lineSize, "L %d:\n", $<my_int>8);		//L N1:
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

methodCall: NAME '(' paramContainer ')' {
									struct node * var = buscar($1);

									if (var->cat == rutina){
										snprintf(line, lineSize, "GT(%d);\t// METH CALL at %d\n", var->dir, lines);
										gc(line);
									}
								
								}
|	NAME '(' ')' 				{
									struct node * var = buscar($1);

									if (var->cat == rutina){
										int localdir = 4*_localdir++;
										/*snprintf(line, lineSize, "\tI(R6 - %d) = R5;\t//METH CALL (no params) at line: %d\n", localdir, lines);	//I(R7 - 8) = R2;
										gc(line);
										snprintf(line, lineSize, "\tR7 = R7 - 4;\t//METH CALL (no params) at line: %d\n", lines);	//R7 = R7 - 12;
										gc(line);*/
										lib_reg_num(entero, 0);

										int retTag = tag();

										// GUARDAR EN R5 LA TAG DE RETORNO
										snprintf(line, lineSize, "\tR5 = %d;\t// METH CALL (no params) at %d\n", retTag, lines);
										gc(line);
										snprintf(line, lineSize, "\tGT(%d);\t// METH CALL (no params) at %d\n", var->dir, lines);
										gc(line);
										snprintf(line, lineSize, "L %d:\t// METH CALL (no params) at %d\n", retTag, lines);
										gc(line);

										/*snprintf(line, lineSize, "\tR5 = I(R6 - %d);\t//METH CALL(no params) at line: %d\n", localdir, lines);	//I(R7 - 8) = R2;
										gc(line);
										snprintf(line, lineSize, "\tR7 = R7 + 4;\t//METH CALL(no params) at line: %d\n", lines);	//R7 = R7 - 12;
										gc(line);*/
										assign_reg_num(entero, 0);

										//insertar("__RET", v_local, entero, localdir);
										/*
										int returnTag = tag();
										
										// ALMACENAR TAG DE REGRESO A LLAMADA DE FUNCIÓN EN MEMORIA
										struct node * ret = buscar("__RET");
										int reg = assign_reg();
										//snprintf(line, lineSize, "\tR%d = I(0x%05x);\t\t// Generated by methodCall (no params) at %d\n", reg, ret->dir, lines);
										//gc(line);
										//snprintf(line, lineSize, "L R%d:\t// Generated by methodCall (no params) at %d\n", reg, lines);
										snprintf(line, lineSize, "\tGT(%d);\t// Generated by methodCall (no params) at %d\n", var->dir, lines);
										gc(line);

										snprintf(line, lineSize, "L %d:\t// Generated by methodCall (no params) at %d\n", ret->dir, lines);
										gc(line);
										*/
									}
								
								}
;

method: /**METH NAME 				{
									
								}
		'('paramContainer')'	{	// (see increaseScope) Add params to inner scope
									
								} 
		':' type				{
									
								}
		increaseScope //add local variables AFTER increasing scope
		contentMeth decreaseScope 	// RETURN isnt forced to be use
|*/	METH NAME '('')'':' type	{
									gc("//inside method (no params)\n");
									/*struct varPack *pack =  malloc(sizeof(struct varPack));
									pack->varReg = assign_reg();
									pack->varType = $<my_type>6; //int
									pack->varCat = rutina;*/
									//$<my_pack>$ = pack;
									
									//snprintf(line, lineSize, "I(R6 - %d) = %d;\t// Generated by meth (no params) at %d\n", meth, lines);
									//gc(line);	
									//insertar(id, v_local, _type, methdir);								
									

									int skipMeth = tag();
									snprintf(line, lineSize, "\tGT(%d);\t\t// Generated by meth (no params) at %d\n", skipMeth, lines);
									gc(line);
									$<my_int>$ = skipMeth;

									/*
									int meth = tag();
									snprintf(line, lineSize, "L %d:\t// Generated by meth (no params) at %d\n", meth, lines);
									insertar("__RET", v_global, nada, meth);
									gc(line);
									
									meth = tag();
									_globalgap++;
									unsigned int dir = _z - 4*_globalgap;
									insertar($2, rutina, $<my_type>6, meth);
									*/

									//int ret = tag();
									//insertar("__RET", v_global, nada, ret);


									int meth = tag();
									snprintf(line, lineSize, "L %d:\t// Generated by meth (no params) at %d\n", meth, lines);
									gc(line);			
									//// Guardar el contenido de los registros r0, r1, r2
									{
										snprintf(line, lineSize, "\tI(R7 - 4) = R0;\t//Generated by METH at line: %d\n", lines);	//I(R7) = R0;
										gc(line);
										snprintf(line, lineSize, "\tI(R7 - 8) = R1;\t//Generated by METH at line: %d\n", lines);	//I(R7 - 4) = R1;
										gc(line);
										snprintf(line, lineSize, "\tI(R7 - 12) = R2;\t//Generated by METH at line: %d\n", lines);	//I(R7 - 8) = R2;
										gc(line);
										snprintf(line, lineSize, "\tI(R7 - 16) = R5;\t//Generated by METH at line: %d\n", lines);		
									gc(line);
										snprintf(line, lineSize, "\tR7 = R7 - 20;\t//Generated by METH at line: %d\n", lines);	//R7 = R7 - 12;
										gc(line);
									}
									////					
									insertar($2, rutina, $<my_type>6, meth);

									//_globalgap++;
									//unsigned int dir = _z - 4*_globalgap;
									

									//struct node * ret = buscar("__RET");
									/*int localdir = 4*_localdir++;
									snprintf(line, lineSize, "I(R6 - %d) = R0;\n", localdir, lines);
									gc(line);
									insertar("__RET", v_local, entero, localdir);*/

								}
								{
									/*_localdir++;
									$<my_int>$ = _localdir*4;
									_DIR = _localdir*4;
									
									snprintf(line, lineSize, "\tR7 = R7 - %d;\n", _localdir*4);		
									gc(line);*/
								}
		increaseScope 			{
									_insideMeth = 1;
									_ldanchor = _localdir;
									++_localdir;
								}// aqui
		contentMeth decreaseScope 	{
										_insideMeth = 0;
										
									//RETURN
									//struct node * ret = buscar("__RET");
									/*int r0 = assign_reg();
									snprintf(line, lineSize, "\tR%d = R0;\t// Generated by meth (no params) at %d\n", r0, lines);
									gc(line);*/
									/*lib_reg(r0);*/

									//// Cargar el contenido guardado en los registros r0, r1, r2
									{
										snprintf(line, lineSize, "\tR7 = R7 + 20;\t//Generated by METH at line: %d\n", lines);	//R7 = R7 - 12;
										gc(line);
										snprintf(line, lineSize, "\tR0 = I(R7 - 4);\t//Generated by METH at line: %d\n", lines);	//I(R7) = R0;
										gc(line);
										snprintf(line, lineSize, "\tR1 = I(R7 - 8);\t//Generated by METH at line: %d\n", lines);	//I(R7 - 4) = R1;
										gc(line);
										snprintf(line, lineSize, "\tR2 = I(R7 - 12);\t//Generated by METH at line: %d\n", lines);	//I(R7 - 8) = R2;
										gc(line);
										snprintf(line, lineSize, "\tR5 = I(R7 - 16);\t//Generated by METH at line: %d\n", lines);		
									gc(line);
										
									}
									////
									_localdir = _ldanchor;
									//printf("ey %d", $<my_int>8);
									methReturn($<my_int>8);
									//SKIP FUNCTION
									snprintf(line, lineSize, "L %d:\t// Generated by meth name at %d\n", $<my_int>7, lines);
									gc(line);
									
								}// RETURN isnt forced to be used
//|	METH NAME '('initializations')'':' type'{'content'}'
;
/**
contentMeth: content
|	content return content
|	content return
|	return content
;
*/
contentMeth: content
//|	return
|	contentMeth contentMeth
;

return: RET  		{
						//
						methReturn();
					}
|	RET expression 	{
						//
						methReturn();
					}
;

type: INT 	{ $<my_int>$ = entero; }
|   FLOAT 	{ $<my_int>$ = flotante; }
|   BOOL 	{ $<my_int>$ = booleano; }
|   CHAR 	{ $<my_int>$ = caracter; }
|   STR 	{ $<my_int>$ = ristra; }
;

comparator: EQ
|	NEQ
|	'>'
|	'<'
|	GTE
|	LTE
//|	AND
//|	OR
;

%%

void gc(char* str){
	fputs(str, qfile);
}

void methReturn(int dir){
	struct node * ret = buscar("__RET");
	//printf("ey2 %d\n", dir);
	/*int meth;
	if (ret == NULL) {
		gc("//first return\n");
		meth = tag();
		insertar("__RET", v_global, nada, meth);
	} else {
		gc("//not first return\n");
		meth = ret->dir;
	}*/
	//_globalgap++;
	//unsigned int dir = _z - 4*_globalgap;
	//snprintf(line, lineSize, "\tI(0x%05x) = %d;\t// Generated by meth (no params) at %d\n", dir, meth, lines);
	//gc(line);
	
	// GET RET DIR FROM DYNAMIC MEMORY
	//snprintf(line, lineSize, "\tR0 = I(R6 - %d);\t// Generated by methReturn (no params) at %d\n", ret->dir, lines);
	//gc(line);
	dir = _DIR;
	snprintf(line, lineSize, "//ey2 %d\n", dir);
	gc(line);
	/*snprintf(line, lineSize, "\tR5 = I(R6 - %d);\t// EY Generated by methReturn (no params) at %d\n", dir, lines);
	printf("ey2 %d\n", dir);
	gc(line);*/
	snprintf(line, lineSize, "\tGT(R5);\t// Generated by methReturn (no params) at %d\n", lines);
	gc(line);
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
	_type = var->tipo;
	if (var == NULL){
		printf("Variable %s no encontrada", var->id);
		return;
	}

	if (pack->varType != _type){
		//gc("//type mismatch\n");
		snprintf(line,lineSize, "//Types mismatch, expected %d but got %d at line %d\n", _type, pack->varType, lines); // 
		gc(line);
		return;
	}

	//printf("initializeVar for %d", pack->varType);
	/*snprintf(line, lineSize, "//Initializing %d variable at line %d\n", pack->varType, lines); 
	gc(line);*/
	if (var->cat == v_global){
		/*snprintf(line,lineSize, "// pack->varType = %d, initializeVar%d\n", pack->varType, lines); // 
		gc(line);*/
		switch(pack->varType){
			case entero:
				snprintf(line, lineSize, "\tI(0x%05x) = R%d;\t\t//Initializing %d variable at line %d\n", var->dir, pack->varReg, pack->varType, lines); 
				gc(line);
				break;
			case flotante:
				snprintf(line, lineSize, "\tF(0x%05x) = RR%d;\t\t//Initializing %d variable at line %d\n", var->dir, pack->varReg, pack->varType, lines); 
				gc(line);
				break;
			case booleano:
				snprintf(line, lineSize, "\tI(0x%05x) = R%d;\t\t//Initializing %d variable at line %d\n", var->dir, pack->varReg, pack->varType, lines); 
				gc(line);
				break;
			case caracter:
				snprintf(line, lineSize, "\tI(0x%05x) = R%d;\t\t//Initializing %d variable at line %d\n", var->dir, pack->varReg, pack->varType, lines); 
				gc(line);
				break;
		}
		
	} else if (var->cat == v_local){
		if (pack->varType == flotante){
			snprintf(line, lineSize, "\tF(R6 - %d) = RR%d;\t\t//Generated by line %d\n", var->dir, pack->varReg, lines); 
		}else{
			snprintf(line, lineSize, "\tI(R6 - %d) = R%d;\t\t//Generated by line %d\n", var->dir, pack->varReg, lines); 
		}
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
	int gap = 4;
	if(_type == flotante){
		gap = 4;
	}
	if (_scope == 0) {
		_globalgap++;
		unsigned int dir = z - _globalgap * gap;
		snprintf(line,lineSize, "STAT(%d)\t\t//Generated by line %d\n", _statcode, lines);
		gc(line);
		snprintf(line,lineSize, "\tDAT(0x%05x,I,0);\t\t//Generated by line %d\n", dir, lines); // 
		gc(line);
		
		snprintf(line,lineSize, "//id: %s\n", id); // 
		gc(line);

		snprintf(line,lineSize, "CODE(%d)\t\t//Generated by declareVar at line %d\n", _statcode++, lines); // 
		gc(line);

		insertar(id, v_global, _type, _z - gap*_globalgap);
	} else {
		_localgap++;
		/*snprintf(line, lineSize, "\tR7 = R7 - %d;\t\t// E Generated by line %d\n", gap, lines);
		gc(line);*/
		insertar(id, v_local, _type, gap*_localdir++);
	}
	_value = 0;
}

void printStr(char* str){
	int retTag = tag();
	_globalgap++;
	unsigned int strDir = _z - _globalgap++ * 4 * (strlen(str));
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
	snprintf(line, lineSize, "L %d:\t//Generated by print\n", retTag);
	gc(line);
	//// Cargar el contenido guardado en los registros r0, r1, r2
	{
		snprintf(line, lineSize, "\tR0 = I(R7 + 12);\t//Generated by print at line: %d\n", lines);	//I(R7) = R0;
		gc(line);
		snprintf(line, lineSize, "\tR1 = I(R7 + 8);\t//Generated by print at line: %d\n", lines);	//I(R7 - 4) = R1;
		gc(line);
		snprintf(line, lineSize, "\tR2 = I(R7 + 4);\t//Generated by print at line: %d\n", lines);	//I(R7 - 8) = R2;
		gc(line);
		snprintf(line, lineSize, "\tR7 = R7 + 16;\t//Generated by print at line: %d\n", lines);	//R7 = R7 - 12;
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
		switch(_type){
			case caracter:
				snprintf(line, lineSize, "\tSTR(0x%05x, \"%%c\\n\");\t//Generated by print\n", strDir);		//STR(dir,"%i");
				break;
			default:
				snprintf(line, lineSize, "\tSTR(0x%05x, \"%%i\\n\");\t//Generated by print\n", strDir);		//STR(dir,"%i");
				break;
		}
		gc(line);
		snprintf(line, lineSize, "CODE(%d)\t//Generated by print\n", _statcode++);		//CODE(dir,"%c");
		gc(line);
		snprintf(line, lineSize, "\tR1 = 0x%05x;\t//Generated by print\n", strDir);		//R1 = dir;
		gc(line);
		snprintf(line, lineSize, "\tR0 = %d;\t//Generated by print\n", retTag);		//R0 = 12; //TODO: Comprobar
		gc(line);
		gc("\tGT(-12);\t//Generated by print\n");
		snprintf(line, lineSize, "L %d:\t//Generated by print\n", retTag);
		gc(line);
	}
	//// Cargar el contenido guardado en los registros r0, r1, r2
	snprintf(line, lineSize, "\tR0 = I(R7 + 12);\t//Generated by print at line: %d\n", lines);	//I(R7) = R0;
	gc(line);
	snprintf(line, lineSize, "\tR1 = I(R7 + 8);\t//Generated by print at line: %d\n", lines);	//I(R7 - 4) = R1;
	gc(line);
	snprintf(line, lineSize, "\tR2 = I(R7 + 4);\t//Generated by print at line: %d\n", lines);	//I(R7 - 8) = R2;
	gc(line);
	snprintf(line, lineSize, "\tR7 = R7 + 16;\t//Generated by print at line: %d\n", lines);	//R7 = R7 - 12;
	gc(line);
	////

}

struct varPack * storeOperand(struct varPack* op){
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
		case flotante:
			snprintf(line,lineSize, "\tRR%d = %f;%s\n",op->varReg,op->val_float, comment);
			break;
		case caracter:
			snprintf(line,lineSize, "\tR%d = \'%c\';%s\n",op->varReg,op->val_char, comment);
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
	//snprintf(comment,lineSize,"\t\t\t// Arithmetical - l:%d",lines);

	snprintf(comment,lineSize, "//%d %c %d\t//Arithmetical",op1->varType,sign,op2->varType);
	//gc(line);

	if ((op1->varType == caracter || op1->varType == entero) && 
		(op2->varType == caracter || op2->varType ==  entero)){
		snprintf(line,lineSize, "\tR%d=R%d%cR%d;%s\n",op1->varReg,op1->varReg,sign,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
	}else if(op1->varType == flotante && op2->varType == 2){
		snprintf(line,lineSize, "\tRR%d=RR%d%cRR%d;%s\n",op1->varReg,op1->varReg,sign,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
	}else if(op1->varType == flotante && op2->varType == entero){
		snprintf(line,lineSize, "\tRR%d=RR%d%cR%d;%s\n",op1->varReg,op1->varReg,sign,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
	}else if(op1->varType == entero && op2->varType == flotante){
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

	if(op1->varType == booleano && op2->varType == booleano){
		if(sign == '!'){
			snprintf(line,lineSize, "\tR%d=%cR%d;%s\n",op1->varReg,sign,op1->varReg, comment);
			result = op1;
		}else{
			snprintf(line,lineSize, "\tR%d=R%d%c%cR%d;%s\n",op1->varReg,op1->varReg,sign,sign,op2->varReg, comment);
			lib_reg(op2);
			result = op1;
		}
	}else{
		snprintf(line,lineSize, "//%d %c %d\t//Logical\n",op1->varType,sign,op2->varType);
		gc(line);
		yyerror("Wrong variable type used");
	}
	gc(line);
	free(comment);
	return result;		
}

struct varPack * relational(struct varPack* op1, char sign, struct varPack* op2){
	struct varPack* result;
	char *comment = malloc(lineSize);
	snprintf(comment,lineSize,"\t\t\t// Relational - l:%d",lines);
	char* signStr;
	switch(sign){
		case 'e':
			signStr = "==";
			break;
		case 'n':
			signStr = "!=";
			break;
		case 'g':
			signStr = ">=";
			break;
		case 'l':
			signStr = "<=";
			break;
		case '<':
			signStr = "<";
			break;
		case '>':
			signStr = ">";
			break;
	}
	snprintf(line,lineSize, "//%d %s %d\t//Relational\n",op1->varType,signStr,op2->varType);
	gc(line);
	if ((op1->varType == caracter || op1->varType == entero) && 
		(op2->varType == caracter || op2->varType == entero) ||
		(op1->varType == booleano && op2->varType == booleano)){

		snprintf(line,lineSize, "\tR%d=R%d%sR%d;%s\n",op1->varReg,op1->varReg,signStr,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
		//op1->varType = booleano;
	}else if(op1->varType == flotante && op2->varType == flotante){
		snprintf(line,lineSize, "\tRR%d=RR%d%sRR%d;%s\n",op1->varReg,op1->varReg,signStr,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
	}else if(op1->varType == flotante && op2->varType == entero){
		snprintf(line,lineSize, "\tRR%d=RR%d%sR%d;%s\n",op1->varReg,op1->varReg,signStr,op2->varReg, comment);
		lib_reg(op2);
		result = op1;
	}else if(op1->varType == entero && op2->varType == flotante){
		snprintf(line,lineSize, "\tRR%d=R%d%sRR%d;%s\n",op2->varReg,op1->varReg,signStr,op2->varReg, comment);
		lib_reg(op1);
		result = op2;
	}else{
		yyerror("Wrong variable type used");
	}
	gc(line);
	free(comment);
	result->varType = booleano;
	return result;		
}

int checkCondition(struct varPack * pack){
	int retTag = tag();
	snprintf(line, lineSize, "//checkCondition()\n");
	gc(line);
	if(pack->varType == flotante){
		snprintf(line, lineSize, "\tRR%d = RR%d == 1;\n", pack->varReg, pack->varReg);
		gc(line);
		snprintf(line, lineSize, "\tIF (!RR%d) GT(%d);\n", pack->varReg, retTag);
		gc(line);
	}else{
		snprintf(line, lineSize, "\tR%d = R%d == 1;\n", pack->varReg, pack->varReg);
		gc(line);
		snprintf(line, lineSize, "\tIF (!R%d) GT(%d);\n", pack->varReg, retTag);
		gc(line);
	}
	
	return retTag;
}

void packInitializer(char* id, struct varPack *expression){
	struct varPack *pack = malloc(sizeof(struct varPack));
	pack->varId = id; 
	pack->varReg = expression->varReg;
	pack->varType = expression->varType;										
	
	initializeVar(pack);
}

int assign_reg_num(int type, int reg){
	if (type == flotante){
		registers_F[reg] = true;
	}
	if (type == entero){
		registers_I[reg] = true;
	}
}

int assign_reg(){
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

void lib_reg_num(int type, int reg){
	if (type == flotante){
		registers_F[reg] = false;
	}
	if (type == entero){
		registers_I[reg] = false;
	}
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
