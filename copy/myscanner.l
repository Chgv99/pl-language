%{
enum yytokentype {
	#define INT 258
	#define FLOAT 259
	#define BOOL 260
	#define CHAR 261
	
	#define ARR 262
	#define STR 263

	#define ADD 264
	#define SUB 265
	#define MUL 266
	#define DIV 267
	#define POW 268
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
		if (tok == NUMBER){ 
			printf(" = %d\n", yylval);
		} else {
			printf("\n");
		}

  	}
	//printf("%8d%8d%8d\n", lines, words, chars);
}
