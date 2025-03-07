%option noyywrap
%{
	#include<stdio.h>
%}

%%
[0-9]+   { printf("Número entero encontrado: %s\n", yytext); }
.        { /* Ignorar otros caracteres */ }

%%
int main()
{
	yylex();
	return 0;
}