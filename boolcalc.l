
%option noyywrap

%{
#define YYSTYPE int
#include "boolcalc.tab.h"
%}

white     [ \t\r]+
true      [Tt][Rr][Uu][Ee]
false     [Ff][Aa][Ll][Ss][Ee]
xor       [Xx][Oo][Rr]

%%

{white}   { }

"&"       { return TOK_AND; }
"|"       { return TOK_OR; }
"!"       { return TOK_NOT; }
{xor}     { return TOK_XOR; }

{true}    { return TOK_TRUE; }
{false}   { return TOK_FALSE; }

"\n"      { return TOK_END; }

.         { return TOK_ERROR; }
