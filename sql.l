%{
#include <stdio.h>
#include <stdlib.h>
#include <string.h>  /* Necesaria para strdup() */
#include "y.tab.h"   /* Asegúrate que coincide con el nombre generado por yacc */
%}

%option noyywrap

LETRA   [a-zA-Z]
DIGITO  [0-9]
ID      {LETRA}({LETRA}|{DIGITO}|_)*
NUMERO  {DIGITO}+
STRING  \"([^\"\\]|\\.)*\"

%%

"INSERT"    { return INSERT; }
"INTO"      { return INTO; }
"VALUES"    { return VALUES; }
{ID}        { yylval.str = strdup(yytext); return IDENTIFIER; }
{NUMERO}    { yylval.num = atoi(yytext); return NUMBER; }
{STRING}    { yylval.str = strdup(yytext); return STRING; }
","         { return COMA; }
"("         { return PAREN_IZQ; }
")"         { return PAREN_DER; }
";"         { return PUNTO_COMA; }
[ \t\n]     ; /* Ignorar espacios en blanco */
.           { printf("Error léxico: carácter no reconocido %s\n", yytext); }

%%