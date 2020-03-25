CC=gcc

scanner : triangle_scanner.l
	lex triangle_scanner.l
	$(CC) lex.yy.c -o scanner

parser : triangle_lexer.l triangle_parser.y
	lex triangle_lexer.l
	yacc triangle_parser.y
	$(CC) y.tab.c -o parser

.PHONY: clean
clean :
	rm -f lex.yy.c lexer y.tab.c parser
