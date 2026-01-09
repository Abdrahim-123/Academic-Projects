%{
extern unsigned lexError;
extern FILE* outFile;
#include <unistd.h>
%}


%%




[ \t]+    {;}

\n      {yylineno++;}

"//"[^\n]*    {;}

"\/\*"(.|\n)*?"\*\/"  {;}




"if"    {
    fprintf(outFile, "<IF, if>\n");
}

"else"  {
    fprintf(outFile, "<ELSE, else>\n");
}

"while" {
    fprintf(outFile, "<WHILE, while>\n");
}

"return"    {
    fprintf(outFile, "<RETURN, return>\n");
}

"struct"    {
    fprintf(outFile, "<STRUCT, struct>\n");
}

"int"   {
    fprintf(outFile, "<TYPE, int>\n");
}

"float" {
    fprintf(outFile, "<TYPE, float>\n");
}

[0-9]+\.(e|E)[+-]?  {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid float or scientific notation \"%s\".\n", yylineno, yytext);
    return 0;
}

[0-9]+\.    {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid float or scientific notation \"%s\".\n", yylineno, yytext);
    return 0;
}

\.(e|E)[+-]?[0-9]+  {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid float or scientific notation \"%s\".\n", yylineno, yytext);
    return 0;
}

\.[0-9]+    {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid float or scientific notation \"%s\".\n", yylineno, yytext);
    return 0;
}


[a-zA-Z_][a-zA-Z0-9_]*  {
    fprintf(outFile, "<ID, %s>\n", yytext);
}



([0-9]+\.[0-9]*|\.[0-9]+)(e|E)[+-]?[0-9]+    {
    fprintf(outFile, "<FLOAT, %s>\n", yytext);
}

[0-9]+(e|E)[+-]?[0-9]+  {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid float or scientific notation \"%s\".\n", yylineno, yytext);
    return 0;
}

[0-9]+\.[0-9]+(e|E)[+-]?[0-9]*[a-zA-Z_]+[0-9a-zA-Z_]*   {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid float or scientific notation \"%s\".\n", yylineno, yytext);
    return 0;
}

[0-9]+\.[0-9]+(e|E)[+-]?    {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid float or scientific notation \"%s\".\n", yylineno, yytext);
    return 0;
}


[0-9]+\.[0-9]+ {
    fprintf(outFile, "<FLOAT, %s>\n", yytext);
}



(0x|0X)[0-9a-fA-F]+ {
    fprintf(outFile, "<INT, %s>\n", yytext);
}


(0)[0-7]*[89][0-9]* {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid octal or hex number \"%s\".\n", yylineno, yytext);
    return 0;
}


(0x|0X)[0-9a-fA-F]*[g-zG-Z_][0-9a-zA-Z_]*    {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid octal or hex number \"%s\".\n", yylineno, yytext);
    return 0;
}


[0-9]+[a-zA-Z_]+    {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Illegal identifier \"%s\".\n", yylineno, yytext);
    return 0;
}

(0)[0-7]+   {
    fprintf(outFile, "<INT, %s>\n", yytext);
}



(0|[1-9][0-9]*)  {
    fprintf(outFile, "<INT, %s>\n", yytext);
}



(0x|0X) {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Illegal identifier \"%s\".\n", yylineno, yytext);
}


"&&"    {
    fprintf(outFile, "<AND, &&>\n");
}

"||"    {
    fprintf(outFile, "<OR, ||>\n");
}


";" {
    fprintf(outFile, "<SEMI, ;>\n");
}

"," {
    fprintf(outFile, "<COMMA, ,>\n");
}

"=" {
    fprintf(outFile, "<ASSIGNOP, =>\n");
}

"+" {
    fprintf(outFile, "<PLUS, +>\n");
}

"-" {
    fprintf(outFile, "<MINUS, ->\n");
}

"*" {
    fprintf(outFile, "<STAR, *>\n");
}

"\/"    {
    fprintf(outFile, "<DIV, \/>\n");
}

"\." {
    fprintf(outFile, "<DOT, .>\n");
}

"!" {
    fprintf(outFile, "<NOT, !>\n");
}

"(" {
    fprintf(outFile, "<LP, (>\n");
}

")" {
    fprintf(outFile, "<RP, )>\n");
}

"[" {
    fprintf(outFile, "<LB, [>\n");
}

"]" {
    fprintf(outFile, "<RB, ]>\n");
}

"{" {
    fprintf(outFile, "<LC, {>\n");
}

"}" {
    fprintf(outFile, "<RC, }>\n");
}

(==|!=|<=|>=|<|>)  {
    fprintf(outFile, "<RELOP, %s>\n", yytext);
}




.   {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Illegal character \"%s\".\n", yylineno, yytext);
    return 0;
}

%%

int yywrap(void) {
    return 1;
}
