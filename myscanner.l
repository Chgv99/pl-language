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
};

int yylval;

int chars = 0;
int words = 0;
int lines = 0;
%}

%%

[-+*/\^] { return yytext[0]; }

[0-9]+ { yylval = atoi(yytext); return INT; }

learn { return LEARN; }
return { return RET; }
end { return END; }
next { return NEXT; }
terminate { return TERM; }

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
