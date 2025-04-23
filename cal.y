%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include <string.h>

void yyerror(const char *s);
int yylex(void);
void print_expression(double val);  // Prototipo de la función

extern FILE *yyin;
char *expression_buffer = NULL;     // Buffer para almacenar la expresión original
%}

%union {
    double dval;
}

%token <dval> NUMERO
%token SUMA RESTA MULT DIV MOD EXP
%token PAR_IZQ PAR_DER
%token SIN COS TAN SEC CSC COT LOG LN
%token NL

%type <dval> expresion termino factor exponente trigonometria logaritmo

%left SUMA RESTA
%left MULT DIV MOD
%right EXP
%right UMINUS UPLUS

%%

programa: 
    | programa linea
    ;

linea: expresion NL { 
        printf("Operación: %s\n", expression_buffer);
        printf("Resultado: %g\n\n", $1); 
        free(expression_buffer);
        expression_buffer = NULL;
    }
    | NL
    ;

expresion: termino { $$ = $1; }
    | expresion SUMA termino { $$ = $1 + $3; }
    | expresion RESTA termino { $$ = $1 - $3; }
    | SUMA expresion %prec UPLUS { $$ = $2; }
    | RESTA expresion %prec UMINUS { $$ = -$2; }
    ;

termino: factor { $$ = $1; }
    | termino MULT factor { $$ = $1 * $3; }
    | termino DIV factor { $$ = $1 / $3; }
    | termino MOD factor { $$ = fmod($1, $3); }
    ;

factor: exponente { $$ = $1; }
    | trigonometria { $$ = $1; }
    | logaritmo { $$ = $1; }
    ;

exponente: NUMERO { $$ = $1; }
    | PAR_IZQ expresion PAR_DER { $$ = $2; }
    | exponente EXP exponente { $$ = pow($1, $3); }
    ;

trigonometria: SIN PAR_IZQ expresion PAR_DER { $$ = sin($3); }
    | COS PAR_IZQ expresion PAR_DER { $$ = cos($3); }
    | TAN PAR_IZQ expresion PAR_DER { $$ = tan($3); }
    | SEC PAR_IZQ expresion PAR_DER { $$ = 1/cos($3); }
    | CSC PAR_IZQ expresion PAR_DER { $$ = 1/sin($3); }
    | COT PAR_IZQ expresion PAR_DER { $$ = 1/tan($3); }
    ;

logaritmo: LOG PAR_IZQ expresion PAR_DER { $$ = log10($3); }
    | LN PAR_IZQ expresion PAR_DER { $$ = log($3); }
    ;

%%

/* Función para capturar la expresión original */
void capture_expression(const char *text) {
    if (expression_buffer) {
        free(expression_buffer);
    }
    expression_buffer = strdup(text);
}

/* Función auxiliar para imprimir la expresión */
void print_expression(double val) {
    if (expression_buffer) {
        printf("%s", expression_buffer);
    } else {
        printf("%g", val);
    }
}

void yyerror(const char *s) {
    fprintf(stderr, "Error: %s\n", s);
    if (expression_buffer) {
        free(expression_buffer);
        expression_buffer = NULL;
    }
}

int main(int argc, char *argv[]) {
    if (argc > 1) {
        yyin = fopen(argv[1], "r");
        if (!yyin) {
            perror("No se pudo abrir el archivo");
            return 1;
        }
    }
    
    printf("Calculadora Científica Avanzada\n");
    printf("Operaciones soportadas: + - * / %% ^ ( )\n");
    printf("Funciones: sin cos tan sec csc cot log ln\n");
    printf("Ingrese expresiones matemáticas (Ctrl+Z para salir):\n");
    
    yyparse();
    
    if (expression_buffer) {
        free(expression_buffer);
    }
    
    if (argc > 1) {
        fclose(yyin);
    }
    
    return 0;
}