%option noyywrap
%{
	#include<stdio.h>
%}
LETTER [a-z]
%%
[aA][eE] { printf("Cadena contiene 'ae'\n"); }
[aA][iI] { printf("Cadena contiene 'ai'\n"); }
[aA][oO] { printf("Cadena contiene 'ao'\n"); }
[aA][uU] { printf("Cadena contiene 'au'\n"); }
. ;
%%
int main()
{
	yylex();
	return 0;
}