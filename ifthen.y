%{
#include <stdio.h>
#include <stdlib.h>
extern int yylex();
extern int yyparse();
extern FILE *yyin;
void yyerror(const char *s);
%}

%union {
    int num;
    char *str;
}

%token IF THEN LPAREN RPAREN SEMICOLON
%token <num> NUM
%token <str> ID

%%

program:
    | program statement
    ;

statement:
    if_statement
    ;

if_statement:
    IF LPAREN condition RPAREN THEN SEMICOLON
    ;

condition:
    ID
    | NUM
    | ID '>' NUM
    | ID '<' NUM
    | ID '=' NUM
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error de sintaxis: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        fprintf(stderr, "Uso: %s archivo_entrada\n", argv[0]);
        return 1;
    }
    
    yyin = fopen(argv[1], "r");
    if (!yyin) {
        perror("Error al abrir el archivo");
        return 1;
    }
    
    if (yyparse() == 0) {
        printf("La estructura if...then... es correcta.\n");
    }
    
    fclose(yyin);
    return 0;
}