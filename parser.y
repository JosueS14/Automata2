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
     | /* vacío */
     ;

defs : /* vacío */
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

tag : /* vacío */
    | '<' IDENTIFIER '>'
    ;

nlist : nmno
      | nlist nmno
      | nlist ',' nmno
      ;

nmno : IDENTIFIER
     | IDENTIFIER NUMBER
     ;

/* Sección de reglas */
rules : C_IDENTIFIER rbody prec
      | rules rule
      ;

rule : C_IDENTIFIER rbody prec
     | '|' rbody prec
     ;

rbody : /* vacío */
      | rbody IDENTIFIER
      | rbody act
      ;

act : '{' /* código C */ '}'
    ;

prec : /* vacío */
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
