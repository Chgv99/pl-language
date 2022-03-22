%{
#include <stdio.h>
#include <stdbool.h>
enum yytokentype {
	LEARN = 258,
	RET = 259,
	END = 260,
	NEXT = 261,
	TERM = 262,

	INT = 263,
	FLOAT = 264,
	BOOL = 265,
	CHAR = 266,
	
	ARR = 267,
	STR = 268,
	EOL = 269,

	COMM = 270,
	RANGE = 271,
	LEN = 272,
	PRINT = 273,

	METH = 274,
	IF = 275,
	AND = 276,
	OR = 277,
	NOT = 278,
	ELSE = 279,
	LOOP = 280,
	FOR = 281,
	WHILE = 282,
	UNTIL = 283,

	EQ = 284,
	NEQ = 285,
	//GT = 286,
	GTE = 286,
	//LT = 288,
	LTE = 287,
	
	NAME = 288,
	
	TRUE = 289,
	FALSE = 290,
	
	VOID = 291,
};

int yylval;

int chars = 0;
int words = 0;
int lines = 1;

bool newline = true;

void error(char*, char*);

%}

%%

[-+*/\^] { return yytext[0]; }
[\(\)\[\]\{\}\,\=] { return yytext[0]; }
[\>\<] { return yytext[0]; }

\=\= { return EQ; }
\!\= { return NEQ; }
\>\= { return GTE; }
\<\=] { return LTE; }

[0-9]+ { yylval = atoi(yytext); return INT; }

int { return INT; }
float { return FLOAT; }
bool { return BOOL; }
char { return CHAR; }

learn { return LEARN; }
return { return RET; }
end { return END; }
next { return NEXT; }
terminate { return TERM; }
~~.* { return COMM; }
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

true { return TRUE; }
false { return FALSE; }
void { return VOID; }

[ \t] { /* ignore whitespaces */ }
\"([^"\n]|\\.)*\" { words++; chars += strlen(yytext); return STR; }
[a-zA-Z]+  { words++; chars += strlen(yytext); return NAME; }
\n         { chars++; lines++; return EOL; }

.          { chars++; error("unexpected token ", yytext); }

%%

void error(char* msg, char* token){
	printf("Error on line %i: %s \"%s\".\n", lines, msg, token);
}
/*void error(char* msg, char* token){
	msg = strcat(msg, token);
	char str[100];

	snprintf(str, sizeof str, "Error on line %i:", lines);
	printf("e.e");
	msg = strcat(&str[0], msg);
	perror(msg);
}*/

main(int argc, char **argv)
{
	int tok;
	while (tok = yylex()){
		//printf("line %i: %d ", lines, tok);
		if (newline) {
			printf("line %i: ", lines);
			newline = false;
		}
		if (tok == INT){ 
			//printf("= %d\n", yylval);
			//printf("line %i: %d ", lines, tok);
		}
		if (tok == 269){ //EOL
			newline = true;
			printf("%d\n", tok);
		}
		else printf("%d ", tok);

  	}
	return 0;
	//printf("%8d%8d%8d\n", lines, words, chars);
}
