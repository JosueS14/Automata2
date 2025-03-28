%{
#include <stdio.h>
#include <string.h>
#include "y.tab.h"
void yyerror(const char *);
%}

%%

"if"        { return IF; }
"then"      { return THEN; }
"("         { return LPAREN; }
")"         { return RPAREN; }
";"         { return SEMICOLON; }
[a-zA-Z][a-zA-Z0-9]*  { yylval.str = strdup(yytext); return ID; }
[0-9]+      { yylval.num = atoi(yytext); return NUM; }
[ \t\n]     ; /* Ignorar espacios en blanco */
.           { return yytext[0]; }

%%

int yywrap(void) {
    return 1;
}