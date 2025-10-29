%{
extern unsigned lexError;
extern FILE* outFile;
%}


%%
/*RULES*/
/*------------------------------------------*/

/*Whitespaces*/
[ \t]+    {;}

\n      {yylineno++;}

"//"[^\n]*    {;}

"\/\*"(.|\n)*?"\*\/"  {;}

/*-----------------------------------------

/*Keywords*/
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

/*------------------------------*/

/*ID*/
[a-zA-Z_][a-zA-Z0-9_]*  {
    fprintf(outFile, "<ID, %s>\n", yytext);
}


/*Valid Scientific Float*/
[0-9]+\.[0-9]+(e|E)[+-]?[0-9]+    {
    fprintf(outFile, "<FLOAT, %s>\n", yytext);
}


/*Invalid Scientific Float*/
[0-9]+\.[0-9]+(e|E)[+-]?    {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid float or scientific notation \"%s\".\n", yylineno, yytext);
}

/*Valid Standard Float*/
[0-9]+\.[0-9]+ {
    fprintf(outFile, "<FLOAT, %s>\n", yytext);



/*Valid Hexadecimel*/
(0x|0X)[0-9a-fA-F]+ {
    fprintf(outFile, "<INT, %s>\n", yytext);
}

/*Invalid Octal*/
(0)[0-7]*[89][0-9]* {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid octal or hex number \"%s\".\n", yylineno, yytext);
}

/*Invalid Hexadecimel*/
(0x|0X)[0-9a-fA-F]*[g-zG-Z_][0-9a-zA-Z_]*    {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Invalid octal or hex number \"%s\".\n", yylineno, yytext);
}

/*Valid Octal*/
(0)[0-7]+   {
    fprintf(outFile, "<INT, %s>\n", yytext);
}


/*Valid Decimal*/
(0|[1-9][0-9]*)  {
    fprintf(outFile, "<INT, %s>\n", yytext);
}


/*Illegal Identtifier*/
(0x|0X) {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Illegal identifier \"%s\".\n", yylineno, yytext);
}

/*Two Char Ops*/
"&&"    {
    fprintf(outFile, "<AND, &&>\n");
}

"||"    {
    fprintf(outFile, "<OR, ||>\n");
}

/*Single Char Ops*/
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

/*---------------*/

/*The Catch all error*/
.   {
    lexError = 1;
    fprintf(outFile, "Lexical Error at Line %d: Illegal character \"%s\".\n", yylineno, yytext);
}

%%

int yywrap(void) {
    return 1;
}