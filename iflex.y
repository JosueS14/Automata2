%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

int yylex(void);
void yyerror(const char *s);
extern int yylineno;
extern char *yytext;
extern FILE *yyin;
%}

%union {
    char *str;
    int num;
}

/* Tokens */
%token TOKEN_IF TOKEN_THEN
%token TOKEN_AND TOKEN_OR
%token TOKEN_LT TOKEN_GT TOKEN_LE TOKEN_GE TOKEN_EQ TOKEN_NE
%token TOKEN_ASSIGN TOKEN_LBRACE TOKEN_RBRACE
%token TOKEN_LPAREN TOKEN_RPAREN TOKEN_SEMI
%token TOKEN_PLUS TOKEN_MINUS TOKEN_MULT TOKEN_DIV
%token <num> TOKEN_NUM
%token <str> TOKEN_ID

/* Precedencia */
%nonassoc TOKEN_EQ TOKEN_NE
%nonassoc TOKEN_LT TOKEN_GT TOKEN_LE TOKEN_GE
%left TOKEN_AND TOKEN_OR
%left TOKEN_PLUS TOKEN_MINUS
%left TOKEN_MULT TOKEN_DIV
%right TOKEN_ASSIGN

%%

program: 
    /* vacío */
    | program statement
    ;

statement: 
    if_statement
    | expression TOKEN_SEMI
    | TOKEN_LBRACE statement_list TOKEN_RBRACE
    | TOKEN_SEMI
    ;

if_statement: 
    TOKEN_IF expression TOKEN_THEN statement
    {
        printf("If-then válido en línea %d\n", yylineno);
    }
    ;

expression: 
    TOKEN_ID
    | TOKEN_NUM
    | expression TOKEN_PLUS expression
    | expression TOKEN_MINUS expression
    | expression TOKEN_MULT expression
    | expression TOKEN_DIV expression
    | expression TOKEN_LT expression
    | expression TOKEN_GT expression
    | expression TOKEN_LE expression
    | expression TOKEN_GE expression
    | expression TOKEN_EQ expression
    | expression TOKEN_NE expression
    | expression TOKEN_AND expression
    | expression TOKEN_OR expression
    | TOKEN_ID TOKEN_ASSIGN expression
    | TOKEN_LPAREN expression TOKEN_RPAREN
    ;

statement_list: 
    statement
    | statement_list statement
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error en línea %d: %s\nToken: '%.10s'\n", 
            yylineno, s, yytext);
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error al abrir archivo");
            return 1;
        }
    }
    
    yyparse();
    
    if (yyin != stdin) fclose(yyin);
    return 0;
}