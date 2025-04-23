%{
#include <stdio.h>
#include <stdlib.h>
#include <math.h>
#include "y.tab.h"

extern char *expression_buffer;
void capture_expression(const char *text);
void yyerror(const char *s);
%}

%%

[ \t]         ; /* Ignorar espacios en blanco */
\n            { capture_expression(yytext); return NL; }
[0-9]+(\.[0-9]+)? { capture_expression(yytext); yylval.dval = atof(yytext); return NUMERO; }
"+"           { capture_expression(yytext); return SUMA; }
"-"           { capture_expression(yytext); return RESTA; }
"*"           { capture_expression(yytext); return MULT; }
"/"           { capture_expression(yytext); return DIV; }
"%"           { capture_expression(yytext); return MOD; }
"^"           { capture_expression(yytext); return EXP; }
"("           { capture_expression(yytext); return PAR_IZQ; }
")"           { capture_expression(yytext); return PAR_DER; }
"sin"         { capture_expression(yytext); return SIN; }
"cos"         { capture_expression(yytext); return COS; }
"tan"         { capture_expression(yytext); return TAN; }
"sec"         { capture_expression(yytext); return SEC; }
"csc"         { capture_expression(yytext); return CSC; }
"cot"         { capture_expression(yytext); return COT; }
"log"         { capture_expression(yytext); return LOG; }
"ln"          { capture_expression(yytext); return LN; }
.             { yyerror("Caracter no reconocido"); }

%%

int yywrap() {
    return 1;
}