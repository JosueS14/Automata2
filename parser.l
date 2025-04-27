%{
#include "y.tab.h"
%}

%%

"%%"         { return MARK; }
"%{"         { return LCURL; }
"%}"         { return RCURL; }
"%token"     { return TOKEN; }
"%left"      { return LEFT; }
"%right"     { return RIGHT; }
"%nonassoc"  { return NONASSOC; }
"%type"      { return TYPE; }
"%start"     { return START; }
"%union"     { return UNION; }
"%prec"      { return PREC; }

[0-9]+       { yylval = atoi(yytext); return NUMBER; }
"'"[^']*"'"  { return IDENTIFIER; }
[a-zA-Z_][a-zA-Z_0-9]*":" { return C_IDENTIFIER; }
[a-zA-Z_][a-zA-Z_0-9]*   { return IDENTIFIER; }

"{"          { return '{'; }
"}"          { return '}'; }
"<"          { return '<'; }
">"          { return '>'; }
","          { return ','; }
";"          { return ';'; }
"|"          { return '|'; }
":"          { return ':'; }
.            { /* ignorar otros */ }

[ \t\n]+     { /* ignorar espacios */ }

%%

int yywrap() {
    return 1;
}
