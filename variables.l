%option noyywrap
%{
#include <stdio.h>
%}

%%
[X1,2,X_1,X_2,A2,A3]*   { printf("Identificador encontrado: %s\n", yytext); }
.                        { /* Ignorar otros caracteres */ }
%%

int main() {
    yylex();
    return 0;
}