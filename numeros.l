%option noyywrap
%{
#include "y.tab.h"
%}

%option noyywrap

%%

[0-9]+      { yylval = atoi(yytext); return NUM; }
"+"         { return ADD; }
"-"         { return SUB; }
"*"         { return MUL; }
"/"         { return DIV; }
[ \t\n\r]   { /* Ignorar espacios y saltos de línea */ }
.           { return yytext[0]; }

%%

int yywrap() {
    return 1;
}
