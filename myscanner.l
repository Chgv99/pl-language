%{
#define ENTERO

int chars = 0;
int words = 0;
int lines = 0;
%}

%%

"+" { printf("PLUS\n"); }

[0-9]+ { printf("NUMBER %s\n", yytext); }

[a-zA-Z]+  { words++; chars += strlen(yytext); }
\n         { chars++; lines++; }
.          { chars++; }

%%

main(int argc, char **argv)
{
	//if (argv > 1) printf("Has args");
	yylex();
  	printf("%8d%8d%8d\n", lines, words, chars);
}
