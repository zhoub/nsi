%option case-insensitive
%option never-interactive
%option nounistd
%option noyywrap
%option yylineno
%option reentrant

%{
#include <cstdio>
#include <cstdlib>
%}

%%
[ \n\t\r]+                    {}

#.+[\n]                       {}

\"([^\\\"]|\\.)*\"            { printf("\tSTRING [%s]\n", yytext); }
[-+]?([0-9]*\.[0-9]+|[0-9]+)* { printf("\tNUMBER [%s]\n", yytext); }

"["                           { printf("\t{\n"); }
"]"                           { printf("\t}\n"); }

Create                        { printf("Create\n"); }
Connect                       { printf("Connect\n"); }
SetAttribute                  { printf("SetAttribute\n"); }

%%

int main(int argc, char *argv[])
{
    -- argc, ++ argv;
    if (! argc)
    {
        return 1;
    }

    yyscan_t scanner = NULL;
    yylex_init(&scanner);
    yyset_debug(1, scanner);
    yyset_in(fopen(argv[0], "r"), scanner);
    yylex(scanner);
    yylex_destroy(scanner);

    return 0;
}
