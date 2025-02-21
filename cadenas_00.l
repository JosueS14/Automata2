%option noyywrap
%{
	#include<stdio.h>
%}
DIGIT [0,1]
%%
^00[01]*$ { printf("Cadena empieza en '00'\n"); }
^[01]*00$ { printf("Cadena termina en '00'\n"); }
. ;
%%
int main()
{
	yylex();
	return 0;
}
