%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include "y.tab.h"

extern YYSTYPE yylval;
%}

DIGITO [0-9]
LETRA [a-zA-Z]
IDENTIFICADOR {LETRA}({LETRA}|{DIGITO}|_)*
DECIMAL {DIGITO}+\.{DIGITO}+
ENTERO {DIGITO}+
ESPACIO [ \t\n]

%%

{ENTERO}        { yylval.entero = atoi(yytext); return ENTERO; }
{DECIMAL}       { yylval.decimal = atof(yytext); return DECIMAL; }
"+"             { return SUMA; }
"-"             { return RESTA; }
"*"             { return MULTIPLICACION; }
"/"             { return DIVISION; }
"("             { return PARENTESIS_IZQ; }
")"             { return PARENTESIS_DER; }
"=="            { return IGUAL; }
"!="            { return DIFERENTE; }
"<"             { return MENOR; }
">"             { return MAYOR; }
"<="            { return MENOR_IGUAL; }
">="            { return MAYOR_IGUAL; }
{IDENTIFICADOR} { yylval.identificador = strdup(yytext); return IDENTIFICADOR; }
{ESPACIO}       { /* Ignorar espacios */ }
.               { printf("Error léxico: carácter no reconocido '%s'\n", yytext); }

%%

int yywrap() {
    return 1;
}