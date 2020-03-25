%start Program
%token endfile identifier number character op leftpar rightpar
%token leftcurl rightcurl leftbrac rightbrac comma colon tilde
%token dot semicolon assignment
%token array begin const_lit do_lit else_lit end func if_lit
%token in let of proc record then type var while_lit

%{
int print(char *, char *);
int yyerror(char *);
int yylex();
%}

%%

Program : SingleCommand { print("Program", "SingleCommand"); }
        ;

Command : SingleCommand { print("Command", "SingleCommand"); }
        | Command semicolon SingleCommand
            { print("Command", "Command ; SingleCommand"); }
        ;

SingleCommand : VName assignment Expression
                { print("SingleCommand", "VName := Expression"); }
              | identifier leftpar ActualParamSeq rightpar
                { print("SingleCommand", "identifier ( ActualParamSeq )"); }
              | begin Command end
                { print("SingleCommand", "BEGIN Command END"); }
              | let Declaration in SingleCommand
                { print("SingleCommand", "LET Declaration IN SingleCommand"); }
              | if_lit Expression then SingleCommand else_lit SingleCommand
                { print("SingleCommand", "IF Expression THEN SingleCommand ELSE SingleCommand"); }
              | while_lit Expression do_lit SingleCommand
                { print("SingleCommand", "WHILE Expression DO SingleCommand"); }
              ;

Expression : SecondaryExpression
                { print("Expression", "SecondaryExpression"); }
           | let Declaration in Expression
                { print("Expression", "LET Declaration IN Expression"); }
           | if_lit Expression then Expression else_lit Expression
                { print("Expression", "IF Expression THEN Expression ELSE Expression"); }
           ;

SecondaryExpression : PrimaryExpression
                        { print("SecondaryExpression", "PrimaryExpression"); }
                    | SecondaryExpression op PrimaryExpression
                        { print("SecondaryExpression", "SecondaryExpression op PrimaryExpression"); }
                    ;

PrimaryExpression : number  { print("PrimaryExpression", "number"); }
                  | character   { print("PrimaryExpression", "character"); }
                  | VName   { print("PrimaryExpression", "VName"); }
                  | identifier leftpar ActualParamSeq rightpar
                    { print("PrimaryExpression", "identifier leftpar ActualParamSeq rightpar"); }
                  | op PrimaryExpression
                    { print("PrimaryExpression", "op PrimaryExpression"); }
                  | leftpar Expression rightpar
                    { print("PrimaryExpression", "( Expression )"); }
                  | leftcurl RecordAggregate rightcurl
                    { print("PrimaryExpression", "{ RecordAggregate }"); }
                  | leftbrac ArrayAggregate rightbrac
                    { print("PrimaryExpression", "[ ArrayAggregate ]"); }
                  ;

RecordAggregate : identifier tilde Expression
                    { print("RecordAggregate", "identifier ~ Expression"); }
                | identifier tilde Expression comma RecordAggregate
                    { print("RecordAggregate", "identifier ~ Expression , RecordAggregate"); }
                ;

ArrayAggregate : Expression
                    { print("ArrayAggregate", "Expression"); }
               | Expression comma ArrayAggregate
                    { print("ArrayAggregate", "Expression , ArrayAggregate"); }
               ;

VName : identifier  { print("VName", "identifier"); }
      | VName dot identifier    { print("VName", "VName . identifier"); }
      | VName leftbrac Expression rightbrac { print("VName", "VName [ Expression ]"); }
      ;

Declaration : SingleDeclaration
                { print("Declaration", "SingleCommand"); }
            | Declaration semicolon SingleDeclaration
                { print("Declaration", "Declaration ; SingleCommand"); }
            ;

SingleDeclaration : const_lit identifier tilde Expression
                    { print("SingleCommand", "CONST identifier ~ Expression"); }
                  | var identifier colon TypeDenoter
                    { print("SingleCommand", "VAR identifier : TypeDenoter"); }
                  | proc identifier leftpar FormalParamSeq rightpar tilde SingleCommand
                    { print("SingleCommand", "PROC identifier ( FormalParamSeq ) ~ SingleCommand"); }
                  | func identifier leftpar FormalParamSeq rightpar colon TypeDenoter tilde Expression
                    { print("SingleCommand", "FUNC identifier ( FormalParamSeq ) : TypeDenoter ~ Expression"); }
                  | type identifier tilde TypeDenoter
                    { print("SingleCommand", "TYPE identifier ~ TypeDenoter"); }
                  ;

FormalParamSeq : /* empty */    { print("FormalParamSeq", "empty"); }
               | ProperFormalParamSeq
                    { print("FormalParamSeq", "ProperFormalParamSeq"); }
               ;

ProperFormalParamSeq : FormalParam  { print("ProperFormalParamSeq", "FormalParam"); }
                     | FormalParam comma ProperFormalParamSeq
                        { print("ProperFormalParamSeq", "FormalParam , ProperFormalParamSeq"); }
                     ;

FormalParam : identifier colon TypeDenoter
                { print("FormalParam", "identifier : TypeDenoter"); }
            | var identifier colon TypeDenoter
                { print("FormalParam", "VAR identifier : TypeDenoter"); }
            | proc identifier leftpar FormalParamSeq rightpar
                { print("FormalParam", "PROC identifier ( FormalParamSeq )"); }
            | func identifier leftpar FormalParamSeq rightpar colon TypeDenoter
                { print("FormalParam", "FUNC identifier ( FormalParamSeq ) : TypeDenoter"); }
            ;

ActualParamSeq : /* empty */    { print("ActualParamSeq", "empty"); }
               | ProperActualParamSeq
                    { print("ActualParamSeq", "ProperActualParamSeq"); }
               ;

ProperActualParamSeq : ActualParam
                        { print("ProperActualParamSeq", "ActualParam"); }
                     | ActualParam comma ProperActualParamSeq
                        { print("ProperActualParamSeq", "ActualParam , ProperActualParamSeq"); }
                     ;

ActualParam : Expression        { print("ActualParam", "Expression"); }
            | var VName         { print("ActualParam", "VAR VName"); }
            | proc identifier   { print("ActualParam", "PROC identifier"); }
            | func identifier   { print("ActualParam", "FUNC identifier"); }
            ;

TypeDenoter : identifier    { print("TypeDenoter", "identifier"); }
            | array number of TypeDenoter
                { print("TypeDenoter", "ARRAY number OF TypeDenoter"); }
            | record RecordTypeDenoter end
                { print("TypeDenoter", "RECORD RecordTypeDenoter END"); }
            ;

RecordTypeDenoter : identifier colon TypeDenoter
                    { print("RecordTypeDenoter", "identifier : TypeDenoter"); }
                  | identifier colon TypeDenoter comma RecordTypeDenoter
                    { print("RecordTypeDenoter", "identifier : TypeDenoter , RecordTypeDenoter"); }
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
