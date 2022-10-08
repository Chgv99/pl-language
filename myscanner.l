%{
#include <stdio.h>
#include <stdbool.h>
#include "y.tab.h"

/*#define LEARN 258
#define RET 259
#define END 260
#define NEXT 261
#define TERM 262

#define INT 263
#define FLOAT 264
#define BOOL 265
#define CHAR 266
	
#define ARR 267
#define STR 268
#define EOL 269

#define COMM 270
#define RANGE 271
#define LEN 272
#define PRINT 273

#define METH 274
#define IF 275
#define AND 276
#define OR 277
#define NOT 278
#define ELSE 279
#define LOOP 280
#define FOR 281
#define WHILE 282
#define UNTIL 283

#define EQ 284
#define NEQ 285
//GT = 286,
#define GTE 286
//LT = 288,
#define LTE 287

#define NAME 288

#define TRUE 289
#define FALSE 290

#define VOID 291*/


//int yylval;

int chars = 0;
int words = 0;
int lines = 1;

int _scope = 0;

bool newline = true;

void error(char*, char*);

%}

%%


[-+*/\^%:.] { return yytext[0]; }
[\(\)\[\]\{\}\,\=] 	{ return yytext[0]; }


[\>\<] { return yytext[0]; }

\-\> { return ARROW; }

\+\= { return INC; }
\-\= { return DEC; }
\*\= { return MULT_ASSIGN; }
\/\= { return DIV_ASSIGN; }

\=\= { return EQ; }
\!\= { return NEQ; }
\>\= { return GTE; }
\<\= { return LTE; }

[0-9]+ { yylval.my_int = atoi(yytext); return DIGIT; }

int { return INT; }
float { return FLOAT; }
bool { return BOOL; }
char { return CHAR; }
str { return STR; }

learn { return LEARN; }
return { return RET; }
end { return END; }
next { return NEXT; }
terminate { return TERM; }
[\~\~].* { /*return COMM;*/ }
range { return RANGE; }
len { return LEN; }
print { return PRINT; }

meth { return METH; }
if { return IF; }
not { return NOT; }
else { return ELSE; }
loop { return LOOP; }
for { return FOR; }
while { return WHILE; }
until { return UNTIL; }
and { return AND; }
or { return OR; }

true { return TRUE; }
false { return FALSE; }
void { return VOID; }

[ \t] { /* ignore whitespaces */ }
\"([^"\n]|\\.)*\" { words++; /**chars += strlen(yytext);*/ yylval.my_str = strdup(yytext); return V_STR; }
[a-zA-Z_][a-zA-Z0-9_]*  { words++; chars += strlen(yytext); yylval.my_str = strdup(yytext); return NAME; }
\n         { chars++; lines++; }

.          { chars++; error("unexpected token ", yytext); }
<<EOF>> { return 0; }
%%

int yywrap() {
	return 1;
}

/*void error(char* msg, char* token){
	printf("Error on line %i: %s \"%s\".\n", lines, msg, token);
}*/

/*void error(char* msg, char* token){
	msg = strcat(msg, token);
	char str[100];

	snprintf(str, sizeof str, "Error on line %i:", lines);
	printf("e.e");
	msg = strcat(&str[0], msg);
	perror(msg);
}*/

//int main(int argc, char **argv)
//int yywrap() 
/**int ()
{
	int tok;
	while (tok = yylex()){
		//printf("line %i: %d ", lines, tok);
		if (newline) {
			//printf("line %i: ", lines);
			newline = false;
		}
		if (tok == INT){ 
			////printf("= %d\n", yylval);
			////printf("line %i: %d ", lines, tok);
		}
		if (tok == 269){ //EOL
			newline = true;
			//printf("%d\n", tok);
		}
		//else //printf("%d ", tok);

  	}
	return 0;
	//printf("%8d%8d%8d\n", lines, words, chars);
}*/
