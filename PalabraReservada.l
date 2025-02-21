%option noyywrap
%{
	#include<stdio.h>
%}
RESERVADA [for,double,public,while,float]
%%
^{RESERVADA}+    printf("Palabra reservada: %s\n", yytext);
.
%%
int main()
{
	yylex();
	return 0;
}