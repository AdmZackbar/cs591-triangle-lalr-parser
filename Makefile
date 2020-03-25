CC=gcc

lexer : triangle_scanner.l
	lex triangle_scanner.l
	$(CC) lex.yy.c -o lexer

.PHONY: clean
clean :
	rm -f lex.yy.c lexer
