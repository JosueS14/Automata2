%option noyywrap
%{
#include <stdio.h>
#include <string.h>

int count = 0;
%}

%%

"//".* { /* Ignorar comentarios de una sola línea */ }

"/*"(.|\n)*?"*/" { /* Ignorar comentarios multilínea */ }

"Poter" { 
    count++; 
    printf("Encontrado: %s\n", yytext); 
    printf("Sustituyendo por: Potter\n");
    printf("Potter");
}

. { 
    printf("%s", yytext); 
}

%%

int main() {
    yyin = fopen("El_Prisionero_de_Azkaban.txt", "r");
    if (!yyin) {
        perror("Error al abrir el archivo");
        return 1;
    }

    yylex();

    printf("\nNúmero de veces que 'Poter' fue encontrado: %d\n", count);

    fclose(yyin);

    return 0;
}
