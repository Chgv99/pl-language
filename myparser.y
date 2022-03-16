%{
#include <stdio.h>

%}

/* tokens */
%token LEARN RET END NEXT TERM
%token INT FLOAT BOOL CHAR
%token ARR STR

%%

line:
    | line exp EOL { printf("= %d\n", $2); }
;

%%

main (int argc, char **argv){
	yyparse();
}

yyerror(char *s){
	fprintf(stderr, "error: %s\n", s);
}
