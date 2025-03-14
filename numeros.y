%{
#include <stdio.h>
#include <stdlib.h>

int yylex(void);
int yyparse(void);
int yyerror(const char *s);

%}

%token NUM
%token ADD SUB MUL DIV

%left ADD SUB
%left MUL DIV

%%

program:
    expression
    {
        printf("Resultado: %d\n", $1);
    }
;

expression:
    expression ADD term
    {
        $$ = $1 + $3;
    }
    | expression SUB term
    {
        $$ = $1 - $3;
    }
    | term
    {
        $$ = $1;
    }
;

term:
    term MUL factor
    {
        $$ = $1 * $3;
    }
    | term DIV factor
    {
        if ($3 == 0) {
            yyerror("Error: División por cero");
            exit(1);
        }
        $$ = $1 / $3;
    }
    | factor
    {
        $$ = $1;
    }
;

factor:
    NUM
    {
        $$ = $1;
    }
    | '(' expression ')'
    {
        $$ = $2;
    }
;

%%

int main() {
    printf("Ingrese una expresión matemática:\n");
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    return 0;
}
