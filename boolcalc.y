
%{
#include <stdio.h>
#define YYSTYPE int

FILE *yyin;
FILE *yyout;

int yylex(void);
void yyerror(char *message);

void showValue(int result);
%}

%token  TOK_TRUE TOK_FALSE
%token  TOK_NOT TOK_AND TOK_OR TOK_XOR
%token  TOK_END
%token  TOK_ERROR

%left   TOK_TRUE TOK_FALSE
%left   TOK_XOR
%left   TOK_OR
%left   TOK_AND
%right  TOK_NOT

%start Input

%%

Input: /* Empty */
     | Input Line
;

Line : TOK_END
     | Expression TOK_END { showValue($1); }
     | error TOK_END { fprintf(yyout, "Syntax error\n"); }
;

Expression : TOK_TRUE { $$ = 1; }
           | TOK_FALSE { $$ = 0; }
           | Expression Expression TOK_AND { $$ = $1 && $2; }
           | Expression Expression TOK_OR { $$ = $1 || $2; }
           | Expression Expression TOK_XOR { $$ = $1 != $2; }
           | Expression TOK_NOT { $$ = !$1; }
;

%%

void showValue(int result)
{
	if (result == 0) {
		fprintf(yyout, "FALSE\n");
	} else {
		fprintf(yyout, "TRUE\n");
	}
}

void yyerror(char *message)
{
	//fprintf(stderr, "Error: %s\n", message);
}

int main(int argc, char *argv[]) {

	yyin = stdin;
	yyout = stdout;

	do {
		yyparse();
	} while(!feof(yyin));

	return 0;
}
