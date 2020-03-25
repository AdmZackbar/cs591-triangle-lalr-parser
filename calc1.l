
%{
/*
#include "y.tab.h"
*/

/*
enum Token {endfile,plus,minus,times,divide,leftpar,rightpar,number};
*/

int line=1;
%}

digit		[0-9]

%%

[ \t]		/* blank or tab */;
[\n]		line++;
";"[^\n]*	/* comment */;

"+"		return plus;
"-"		return minus;
"*"		return times;
"/"		return divide;
"("		return leftpar;
")"		return rightpar;

{digit}+	{ yylval=atoi(yytext); return number; }

.		printf("\tError on line %d at character %s\n", line, yytext);

%%

/*
int main() {
    int token;
    do {
    	token=yylex();
    	printf("%d ", token);
	switch (token) {
	  case endfile:	printf("EndFile\n"); break;
	  case plus:	printf("Plus\n"); break;
	  case minus:	printf("Minus\n"); break;
	  case times:	printf("Times\n"); break;
	  case divide:	printf("Divide\n"); break;
	  case leftpar:	printf("LeftPar\n"); break;
	  case rightpar:printf("RightPar\n"); break;
	  case number:	printf("Number  %d\n", yylval);
	}
    }
    while (token);
    return 0;
}
*/

int yywrap() {		/* wrap up normally at end-of-file (control-D) */
    return 1;
}

