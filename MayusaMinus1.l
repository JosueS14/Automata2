%option noyywrap
%{
#include <stdio.h>
#include <ctype.h> // Para la funci�n tolower()
%}

%%

[A-Z]   { /* Si es una letra may�scula */
            char min = tolower(yytext[0]); /* Convertir a min�scula */
            putchar(min);
        }
.|\n    { /* Cualquier otro car�cter */
            putchar(yytext[0]);
        }

%%

int main() {
    printf("Ingrese el texto a convertir:\n");
    yylex(); // Ejecuta el an�lisis l�xico
    return 0;
}
