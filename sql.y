%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>

extern FILE *yyin;
extern int yylex();
extern int yyparse();

void yyerror(const char *s) {
    fprintf(stderr, "Error sintáctico: %s\n", s);
}
%}

%union {
    char *str;
    int num;
}

%token INSERT INTO VALUES
%token <str> IDENTIFIER STRING
%token <num> NUMBER
%token COMA PAREN_IZQ PAREN_DER PUNTO_COMA

%%

sql_statement: insert_statement
    ;

insert_statement: INSERT INTO IDENTIFIER VALUES PAREN_IZQ value_list PAREN_DER PUNTO_COMA
    {
        printf("Instrucción INSERT válida\n");
    }
    ;

value_list: value
    | value COMA value_list
    ;

value: STRING
    | NUMBER
    ;

%%

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("Error al abrir el archivo");
            return 1;
        }
    }
    
    yyparse();
    
    if (yyin != stdin) fclose(yyin);
    return 0;
}