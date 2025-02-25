%option noyywrap
%{
	#include<stdio.h>
%}
%%
[a-zA-Z]*	{printf("Texto: %s\n", yytext);}
[0-9]+		{printf("Digit: %s\n", yytext);}
[+,-,/,*]	{printf("Operator: %s\n", yytext);}
.;


%%
int main()
{
	yylex();
	return 0;
}