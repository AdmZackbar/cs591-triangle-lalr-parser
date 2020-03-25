
%start S
%token endfile plus minus times divide leftpar rightpar number

%{
int print(char *, char *);
int yyerror(char *);
int yylex();
%}

%%

S	:	Expr			{ print ("S", "Expr"); }
	;

Expr	:	Term			{ print ("Expr", "Term"); }
	|	Expr plus Term		{ print ("Expr", "Expr + Term"); }
	|	Expr minus Term		{ print ("Expr", "Expr - Term"); }
	;

Term	:	Factor			{ print ("Term", "Factor"); }
	|	Term times Factor	{ print ("Term", "Term * Factor"); }
	|	Term divide Factor	{ print ("Term", "Term / Factor"); }
	;

Factor	:	leftpar Expr rightpar	{ print ("Factor", "( Expr )"); }
	|	number			{ print ("Factor", "number"); }
	;

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

