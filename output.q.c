#include "Q.h"
BEGIN
L 0:						// Inicio del programa
STAT(0)	// Memoria estática
CODE(0)
	R7 = R7 - 4;
	R6 = R7;
STAT(1)		//Generated by line 3
	DAT(0x11ffc,I,0);		//Generated by line 3
//id: a
CODE(1)		//Generated by declareVar at line 3
	R0 = 10;			// StoreOperand at line:3
	R1 = I(0x11ffc);	//Generated by NAME at line: 3
	R0=R0>R0;			// Relational - l:3
//checkCondition()
	R0 = R0 == 1;
	IF (!R0) GT(1);
//printing an ID: a
	I(R7 - 4) = R0;	//Generated by print at line: 4
	I(R7 - 8) = R1;	//Generated by print at line: 4
	I(R7 - 12) = R2;	//Generated by print at line: 4
	R7 = R7 - 16;	//Generated by print at line: 4
	R0 = 2;	//Generated by print at line: 4
	R2 = I(0x11ffc);	//Generated by print
STAT(2)	//Generated by print
	STR(0x11ff8, "%i\n");	//Generated by print
CODE(2)	//Generated by print
	R1 = 0x11ff8;	//Generated by print
	R0 = 2;	//Generated by print
	GT(-12);	//Generated by print
L 2:	//Generated by print
	R0 = I(R7 + 12);	//Generated by print at line: 4
	R1 = I(R7 + 8);	//Generated by print at line: 4
	R2 = I(R7 + 4);	//Generated by print at line: 4
	R7 = R7 + 16;	//Generated by print at line: 4
	//if content
//end if()
L 1: 
//printing a STR: END
STAT(3)	//Generated by print
	STR(0x11fd0,"END\n");		//Generated by line 7
CODE(3)	//Generated by print
	I(R7 - 4) = R0;	//Generated by print at line: 7
	I(R7 - 8) = R1;	//Generated by print at line: 7
	I(R7 - 12) = R2;	//Generated by print at line: 7
	R7 = R7 - 16;	//Generated by print at line: 7
	R0 = 3;		//Generated by line 7
	R1 = 0x11fd0;		//Generated by line 7
	R2 = 0;		//Generated by line 7
	GT(-12);	//Generated by print
L 3:	//Generated by print
	R0 = I(R7 + 12);	//Generated by print at line: 7
	R1 = I(R7 + 8);	//Generated by print at line: 7
	R2 = I(R7 + 4);	//Generated by print at line: 7
	R7 = R7 + 16;	//Generated by print at line: 7
GT(-2);
END
