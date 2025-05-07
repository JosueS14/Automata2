%{
#include <stdio.h>
#include <stdlib.h>
int yylex();
void yyerror(const char *s);
%}

%token NUMBER MUL ADD LPAREN RPAREN NEWLINE

%%

line: expr NEWLINE { printf("Expresión válida\n"); exit(0); }
    ;

expr: expr ADD term
    | term
    ;

term: term MUL factor
    | factor
    ;

factor: NUMBER
      | LPAREN expr RPAREN
      ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    exit(1);
}

int main() {
    yyparse();
    return 0;
}