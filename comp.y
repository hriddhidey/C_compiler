%{
#include<stdio.h>
#include<stdlib.h>
#include "lex.yy.c"
#include<ctype.h>
extern FILE*fp;
%}

%token INT FLOAT CHAR DOUBLE VOID FOR WHILE IF ELSE PRINTF STRUCT NUM ID INCLUDE DOT

%right '='
%left AND OR
%left '<' '>' LE GE EQ NE LT GT

%%
start: Function
      |Declaration
      ;

/*Declarationblock*/

Declaration: TypeAssignment ';'
            |Assignment ';'
	    	|FunctionCall ';'
			|ArrayUsage ';'
			|TypeArrayUsage ';'
			|StructStmt ';'
			|ReturnStmt ';'
			|error
			;

/*Assignmentblock*/
Assignment: ID '=' Assignment
			|ID '=' FunctionCall
			|ID '=' ArrayUsage
			|ArrayUsage '=' Assignment
			|ID ', 'Assignment
			|NUM ',' Assignment
			|ID '+' Assignment
			|ID '‐' Assignment
			|ID '*' Assignment
			|ID '/' Assignment
			|NUM '+' Assignment
			|NUM '‐' Assignment
			|NUM '*' Assignment
			|NUM '/' Assignment
			|'\' Assignment '\'
			|'(' Assignment ')'
			|'‐' '(' Assignment ')'
			|'‐' NUM
			|'‐' ID
			|NUM
			|ID
			;

/*FunctionCallBlock*/
FunctionCall:ID'('')'
			;

/*ArrayUsage*/
ArrayUsage:ID'['Assignment']'
			;

/*Functionblock*/
Function:TypeID'('ArgListOpt')'CompoundStmt
		;
ArgListOpt:ArgList
		|
		;
ArgList: ArgList','Arg
		|Arg
		;
Arg: TypeID
	;
CompoundStmt: '{'StmtList'}'
			;
StmtList: StmtStmtList
		|
		;
Stmt:WhileStmt
	|Declaration
	|ForStmt
	|IfStmt
	|PrintFunc
	|ReturnStmt
	|';'
	;

/*TypeIdentifierblock*/
Typ:INT
	|FLOAT
	|CHAR
	|DOUBLE
	|VOID
	;

/*LoopBlocks*/
WhileStmt:WHILE'('Expr')'Stmt
	|WHILE'('Expr')'CompoundStmt
	;

/*ForBlock*/
ForStmt:FOR'('Expr';'Expr';'Expr')'Stmt
	|FOR'('Expr';'Expr';'Expr')'CompoundStmt
	|FOR'('Expr')'Stmt
	|FOR'('Expr')'CompoundStmt
	;

/*IfStmtBlock*/
IfStmt:IF'('Expr')'
		;

/*StructStatement*/
StructStmt:STRUCTID'{'TypeAssignment'}'
			;

/*PrintFunction*/
PrintFunc:PRINTF'('Expr')'';'
		|Stmt
		|PRINTF'(''"'ID'"'')'';'
		|PRINTF'(''"''%''"'','ID ')'';'
		;

/*ReturnBlock*/
ReturnStmt:'r''e''t''u''r''n'''Assignment';'
			;

/*ExpressionBlock*/
Expr:ExprLEExpr
	|ExprGEExpr
	|ExprNEExpr
	|ExprEQExpr
	|ExprGTExpr
	|ExprLTExpr
	|Assignment
	|ArrayUsage
	;

%%
intcount=0;
intmain(intargc,char*argv[])
{
	yyin=fopen(argv[1],"r");
	if(!yyparse())
	else
	printf("\nParsingcomplete\n");
	printf("\nParsingfailed\n");
	fclose(yyin);
	return0;
}

yyerror(char*s){
printf("%d:%s%s\n",yylval,s,yytext);
}
