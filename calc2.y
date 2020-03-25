
%start S
%token endfile plus minus times divide leftpar rightpar number

%{
int display(int n);
int yyerror(char *);
int yylex();
%}

%%

S	:	Expr			{ display($1); }
	;

Expr	:	Term			{ $$ = $1; }
	|	Expr plus Term		{ $$ = $1+$3; }
	|	Expr minus Term		{ $$ = $1-$3; }
	;

Term	:	Factor			{ $$ = $1; }
	|	Term times Factor	{ $$ = $1*$3; }
	|	Term divide Factor	{ $$ = $1/$3; }
	;

Factor	:	leftpar Expr rightpar	{ $$ = $2; }
	|	number			{ $$ = yylval; }
	;

%%

#include "lex.yy.c"		/* imports yylex( ) and yywrap( ) */

int display(int n) {
	printf ("Result = %d\n", n);
}

int yyerror(char *message) {
	printf("\tError on line %d is %s\n", line, message);
}

int main() {
	yyparse();
	return 0;
}

