%{
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
	GTE = 287,
	//LT = 288,
	LTE = 289,
};

int yylval;

int chars = 0;
int words = 0;
int lines = 0;
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

learn { return LEARN; }
return { return RET; }
end { return END; }
next { return NEXT; }
terminate { return TERM; }
~~ { return COMM; }
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


[ \t] { /* ignore whitespaces */ }

[a-zA-Z]+  { words++; chars += strlen(yytext); }
\n         { chars++; lines++; return EOL; }
.          { chars++; }

%%

main(int argc, char **argv)
{
	int tok;
	//if (argv > 1) printf("Has args");
	while (tok = yylex()){
		printf("%d", tok);
		if (tok == INT){ 
			printf(" = %d\n", yylval);
		} else {
			printf("\n");
		}

  	}
	//printf("%8d%8d%8d\n", lines, words, chars);
}
