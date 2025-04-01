%{
#include <stdio.h>
#include <string.h>
#include <stdlib.h>

extern int yylex();
extern int yyparse();
extern FILE *yyin;

void yyerror(const char *s);
%}

%union {
    int entero;
    float decimal;
    char *identificador;
}

%token <entero> ENTERO
%token <decimal> DECIMAL
%token <identificador> IDENTIFICADOR
%token SUMA RESTA MULTIPLICACION DIVISION
%token PARENTESIS_IZQ PARENTESIS_DER
%token IGUAL DIFERENTE MENOR MAYOR MENOR_IGUAL MAYOR_IGUAL

%type <decimal> expresion termino factor

%%

inicio: 
    | inicio expresion { printf("Expresión válida: valor = %f\n", $2); }
    ;

expresion: 
    expresion SUMA termino { $$ = $1 + $3; }
    | expresion RESTA termino { $$ = $1 - $3; }
    | termino { $$ = $1; }
    ;

termino: 
    termino MULTIPLICACION factor { $$ = $1 * $3; }
    | termino DIVISION factor { 
        if($3 == 0) {
          yyerror("División por cero");
          YYERROR;
        }
        $$ = $1 / $3; 
      }
    | factor { $$ = $1; }
    ;

factor: 
    PARENTESIS_IZQ expresion PARENTESIS_DER { $$ = $2; }
    | ENTERO { $$ = (float)$1; }
    | DECIMAL { $$ = $1; }
    | IDENTIFICADOR { 
        // Aquí iría la lógica para obtener el valor de la variable
        yyerror("Identificadores no implementados");
        YYERROR;
        $$ = 0; 
      }
    ;

%%

void yyerror(const char *s) {
    fprintf(stderr, "Error sintáctico: %s\n", s);
}

int main(int argc, char *argv[]) {
    if (argc != 2) {
        printf("Uso: %s archivo.txt\n", argv[0]);
        return 1;
    }

    yyin = fopen(argv[1], "r");
    if (!yyin) {
        printf("No se pudo abrir el archivo %s\n", argv[1]);
        return 1;
    }

    yyparse();
    fclose(yyin);
    return 0;
}