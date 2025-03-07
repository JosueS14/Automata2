%option noyywrap
%{
#include <stdio.h>
%}

%%
[A-Z]{4}[0-9]{6}[HM][A-Z]{5}[0-9]{2}   { printf("CURP encontrado: %s\n", yytext); }
.                                      { /* Ignorar otros caracteres */ }
%%

int main() {
    yylex();
    return 0;
}