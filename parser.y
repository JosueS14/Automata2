%{
#include <stdio.h>
%}

/* Tokens */
%token IDENTIFIER
%token C_IDENTIFIER
%token NUMBER
%token LEFT RIGHT NONASSOC TOKEN PREC TYPE START UNION
%token MARK
%token LCURL RCURL

%start spec

%%

spec : defs MARK rules tail
     ;

tail : MARK
     | /* vac�o */
     ;

defs : /* vac�o */
     | defs def
     ;

def : START IDENTIFIER
    | UNION
    | LCURL RCURL
    | ndefs rword tag nlist
    ;

rword : TOKEN
      | LEFT
      | RIGHT
      | NONASSOC
      | TYPE
      ;

tag : /* vac�o */
    | '<' IDENTIFIER '>'
    ;

nlist : nmno
      | nlist nmno
      | nlist ',' nmno
      ;

nmno : IDENTIFIER
     | IDENTIFIER NUMBER
     ;

/* Secci�n de reglas */
rules : C_IDENTIFIER rbody prec
      | rules rule
      ;

rule : C_IDENTIFIER rbody prec
     | '|' rbody prec
     ;

rbody : /* vac�o */
      | rbody IDENTIFIER
      | rbody act
      ;

act : '{' /* c�digo C */ '}'
    ;

prec : /* vac�o */
     | PREC IDENTIFIER
     | PREC IDENTIFIER act
     | prec ';'
     ;

%%

int main() {
    yyparse();
    return 0;
}

int yyerror(const char *s) {
    printf("Error: %s\n", s);
    return 0;
}
