%{
#include "y.tab.h"
%}

%%

[0-9]+   { return NUMBER; }
"*"      { return MUL; }
"+"      { return ADD; }
"("      { return LPAREN; }
")"      { return RPAREN; }
\n       { return NEWLINE; }   /* Usar \n en lugar de \r\n */
[ \t]    ; /* Ignorar espacios */
.        { printf("Carácter inválido: %c\n", yytext[0]); exit(1); }

%%

int yywrap() { return 1; }