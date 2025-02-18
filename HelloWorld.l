%option noyywrap
%{
	#include<stdio.h>
%}

%%
. printf("Hello World\n");
%%
int main()
{
        yylex();
	return 0;
}