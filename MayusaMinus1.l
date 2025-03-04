%option noyywrap
%{
#include <stdio.h>
#include <ctype.h> // Para la función tolower()
%}

%%

[A-Z]   { /* Si es una letra mayúscula */
            char min = tolower(yytext[0]); /* Convertir a minúscula */
            putchar(min);
        }
.|\n    { /* Cualquier otro carácter */
            putchar(yytext[0]);
        }

%%

int main() {
    printf("Ingrese el texto a convertir:\n");
    yylex(); // Ejecuta el análisis léxico
    return 0;
}
