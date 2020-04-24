Purpose:
This program takes in triangle source files and parses them with the aid of LEX and YACC. These programs utilize LALR1 grammar, and output the result in that format.

Building:
Use 'make scanner' to build just the scanner that lexes the program into tokens.
Use 'make parser' to build the parser that syntactically analyzes the programs.

Usage:
Simply run scanner/parser to start the program. To feed in a source program, use piping (also use piping for output).
E.G. ./parser < ./example.tri

Cleaning:
Use 'make clean' to remove all executables and files used for the build.

Notes:
Examples files can be found in the directory 'Examples', and their correct outputs can be found in the directory 'Output'.
