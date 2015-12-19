%{
#include"y.tab.h"
externintyylval;
%}

alpha[a‐zA‐Z]
digit[0‐9]

%%
[\t] ;
[\n] {yylval=yylval+1;}
int returnINT;
float returnFLOAT;
char returnCHAR;
void returnVOID;
double returnDOUBLE;
for returnFOR;
while returnWHILE;
if returnIF;
else returnELSE;
printf returnPRINTF;
struct returnSTRUCT;
^"#include<".+">\n" ;
{digit}+ returnNUM;
{alpha}({alpha}|{digit})* returnID;
"<=" returnLE;
">=" returnGE;
"==" returnEQ;
"!=" returnNE;
">" returnGT;
"<" returnLT;
"." returnDOT;
\/\/.* ;
\/\*(.*\n)*.*\*\/ ;
. returnyytext[0];
%%
