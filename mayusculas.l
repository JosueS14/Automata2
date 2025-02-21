%option noyywrap
%{
	#include<stdio.h>
%}
MAYUS [A-Z]
MINIS [a-z]
%%
[A-Z][a-z]* { printf("Palabra con mayúscula detectada: %s\n", yytext); }
. ;
%%
int main()
{
	yylex();
	return 0;
}