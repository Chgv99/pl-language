%{
enum yytokentype {
	INT = 258,
	FLOAT = 259,
	BOOL = 260,
	CHAR = 261,
	
	ARR = 262,
	STR = 263,

	ADD = 264,
	SUB = 265,
	MUL = 266,
	DIV = 267,
	POW = 268
};

int yylval;

int chars = 0;
int words = 0;
int lines = 0;
%}

%%

"+" { return ADD; }
"-" { return SUB; }
"*" { return MUL; }
"/" { return DIV; }
"^" { return POW; }

[0-9]+ { yylval = atoi(yytext); return INT; }

[ \t] { /* ignore whitespaces */ }

[a-zA-Z]+  { words++; chars += strlen(yytext); }
\n         { chars++; lines++; }
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
