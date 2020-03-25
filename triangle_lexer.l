
%{
/*
enum Token {endfile,op,leftpar,rightpar,number,identifier,
			begin,end,let,in,if_lit,then,else_lit,while_lit,do_lit,
			semicolon,assignment,leftcurl,rightcurl,leftbrac,
			rightbrac,tilde,comma,dot,const_lit,var,proc,func,colon,
			type,array,of,record,character};
*/
int line=1;
%}

digit		[0-9]

%%

[ \t]		/* blank or tab */;
[\n]		line++;
"!"[^\n]*	/* comment */;

"("		return leftpar;
")"		return rightpar;
"{"		return leftcurl;
"}"		return rightcurl;
"["		return leftbrac;
"]"		return rightbrac;
","		return comma;
":"		return colon;
"~"		return tilde;
"."		return dot;
";"		return semicolon;
":="	return assignment;

"array"		return array;
"begin"		return begin;
"const"		return const_lit;
"do"		return do_lit;
"else"		return else_lit;
"end"		return end;
"func"		return func;
"if"		return if_lit;
"in"		return in;
"let"		return let;
"of"		return of;
"proc"		return proc;
"record"	return record;
"then"		return then;
"type"		return type;
"var"		return var;
"while"		return while_lit;

[+\-*\/=<>\\&@%^?]+		return op;
['][^\n][']				return character;
[a-zA-Z][a-zA-Z0-9]*	return identifier;
{digit}+				{ yylval=atoi(yytext); return number; }

.		printf("\tError on line %d at character %s\n", line, yytext);

%%

/*
int main() {
    int token;
    do {
    	token=yylex();
    	printf("%d ", token);
	switch (token) {
	  case endfile:		printf("EndFile\n"); break;
	  case leftpar:		printf("LeftPar\n"); break;
	  case rightpar:	printf("RightPar\n"); break;
	  case leftcurl:	printf("LeftCurl\n"); break;
	  case rightcurl:	printf("RightCurl\n"); break;
	  case leftbrac:	printf("LeftBrac\n"); break;
	  case rightbrac:	printf("RightBrac\n"); break;
	  case comma:		printf("Comma\n"); break;
	  case colon:		printf("Colon\n"); break;
	  case tilde:		printf("Tilde\n"); break;
	  case dot:			printf("Dot\n"); break;
	  case semicolon:	printf("Semicolon\n"); break;
	  case assignment:	printf("Assignment\n"); break;
	  case array:		printf("Array\n"); break;
	  case begin:		printf("Begin\n"); break;
	  case const_lit:	printf("Const\n"); break;
	  case do_lit:		printf("Do\n"); break;
	  case else_lit:	printf("Else\n"); break;
	  case end:			printf("End\n"); break;
	  case func:		printf("Func\n"); break;
	  case if_lit:		printf("If\n"); break;
	  case in:			printf("In\n"); break;
	  case let:			printf("Let\n"); break;
	  case of:			printf("Of\n"); break;
	  case proc:		printf("Proc\n"); break;
	  case record:		printf("Record\n"); break;
	  case then:		printf("Then\n"); break;
	  case type:		printf("Type\n"); break;
	  case var:			printf("Var\n"); break;
	  case while_lit:	printf("While\n"); break;
	  case op:				printf("Operator  %s\n", yytext); break;
	  case character:		printf("Char-Literal  %s\n", yytext); break;
	  case identifier:		printf("Identifier  %s\n", yytext); break;
	  case number:			printf("Number  %d\n", yylval); break;
	}
    }
    while (token);
    return 0;
}
*/

int yywrap() {		/* wrap up normally at end-of-file (control-D) */
    return 1;
}

