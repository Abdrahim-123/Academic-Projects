#include <stdio.h>

extern void yyrestart(FILE*);
unsigned lexError = 0;
extern int yylex();
extern FILE* yyin;
extern int yylineno;
FILE* outFile = NULL;

int main(int argc, char** argv) {
    char inputPath[256], outputPath[256];
    FILE *inputFile, *outputFile;

    for (int i = 1; i <= 45; ++i) {
        snprintf(inputPath, sizeof(inputPath), "test/in/%d.cmm", i);
        snprintf(outputPath, sizeof(outputPath), "my-output/%d.out", i);

        inputFile = fopen(inputPath, "r");
        if (!inputFile) {
            perror(inputPath);
            continue;
        }

        outputFile = fopen(outputPath, "w");
        if (!outputFile) {
            perror(outputPath);
            fclose(inputFile);
            continue;
        }

        yyin = inputFile;
        outFile = outputFile;
        yylineno = 1;
        yyrestart(yyin);

	fflush(outFile);
	lexError = 0;
        yylex();

        fclose(inputFile);
        fclose(outputFile);
    }

    return 0;
}
