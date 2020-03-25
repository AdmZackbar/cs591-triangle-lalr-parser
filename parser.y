%start S
%token 

%{
int print(char *, char *);
int yyerror(char *);
int yylex();
%}

%%



%%

#include "lex.yy.c"		/* imports yylex( ) and yywrap( ) */

int print(char *left, char *right) {
	printf("%s --> %s\n", left, right);
}

int yyerror(char *message) {
	printf("\tError on line %d is %s\n", line, message);
}

int main() {
	yyparse();
	return 0;
}
