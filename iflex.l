%{
#include <string.h>
#include "y.tab.h"

int yylineno = 1;
%}

%option noyywrap nounput noinput

DIGITO    [0-9]
LETRA     [a-zA-Z]
ID        {LETRA}({LETRA}|{DIGITO}|_)*
NUMERO    {DIGITO}+(\.{DIGITO}+)?([eE][+-]?{DIGITO}+)?
CADENA    \"([^\"\\]|\\.)*\"
ESPACIO   [ \t]
SALTO     \n

%%

"if"       { return TOKEN_IF; }
"then"     { return TOKEN_THEN; }
"and"      { return TOKEN_AND; }
"or"       { return TOKEN_OR; }
"<="       { return TOKEN_LE; }
">="       { return TOKEN_GE; }
"=="       { return TOKEN_EQ; }
"!="       { return TOKEN_NE; }
"<"        { return TOKEN_LT; }
">"        { return TOKEN_GT; }
"="        { return TOKEN_ASSIGN; }
"+"        { return TOKEN_PLUS; }
"-"        { return TOKEN_MINUS; }
"*"        { return TOKEN_MULT; }
"/"        { return TOKEN_DIV; }
"{"        { return TOKEN_LBRACE; }
"}"        { return TOKEN_RBRACE; }
"("        { return TOKEN_LPAREN; }
")"        { return TOKEN_RPAREN; }
";"        { return TOKEN_SEMI; }
{CADENA}   { yylval.str = strdup(yytext); return TOKEN_CADENA; }
{ID}       { yylval.str = strdup(yytext); return TOKEN_ID; }
{NUMERO}   { yylval.num = atof(yytext); return TOKEN_NUM; }
{ESPACIO}  ;
{SALTO}    { yylineno++; }
.          { fprintf(stderr, "Error léxico en línea %d: '%s'\n", yylineno, yytext); }

%%

char* strdup(const char* s) {
    char* d = malloc(strlen(s) + 1);
    if (d) strcpy(d, s);
    return d;
}