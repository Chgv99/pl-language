#include "Q.h"
BEGIN
L 0:						// Inicio del programa
STAT(0)	// Memoria estática
CODE(0)
	R7 = R7 - 4;
	R6 = R7;
STAT(1)		//Generated by line 1
	DAT(0x11ffc,I,0);		//Generated by line 1
//id: a
CODE(1)		//Generated by declareVar at line 1
	R0 = 13;			// StoreOperand at line:2
// pack->varType = 1, initializeVar2
	I(0x11ffc) = R0;		//Generated by line 2
STAT(2)		//Generated by line 2
	DAT(0x11ff8,I,0);		//Generated by line 2
//id: b
CODE(2)		//Generated by declareVar at line 2
	R0 = 8;			// StoreOperand at line:4
// pack->varType = 1, initializeVar4
	I(0x11ff8) = R0;		//Generated by line 4
	R0 = I(0x11ffc);	//Generated by NAME at line: 4
	R1 = I(0x11ff8);	//Generated by NAME at line: 4
	R0=R0==R1;			// Logical - l:4
//checkCondition()
	R0 = R0 == 1;
	IF (!R0) GT(1);
	R7 = R7 - 4;		// E Generated by line 5
	R1 = 1;			// StoreOperand at line:6
	I(R6 - 4) = R1;		//Generated by line 6
//printing an ID: c
	I(R7 - 4) = R0;	//Generated by print at line: 6
	I(R7 - 8) = R1;	//Generated by print at line: 6
	I(R7 - 12) = R2;	//Generated by print at line: 6
	R7 = R7 - 16;	//Generated by print at line: 6
	R0 = 2;	//Generated by print at line: 6
	R2 = I(R6 - 4);	//Generated by print
STAT(3)	//Generated by print
	STR(0x11ff4, "%i\n");	//Generated by print
CODE(3)	//Generated by print
	R1 = 0x11ff4;	//Generated by print
	R0 = 2;	//Generated by print
	GT(-12);	//Generated by print
L 2:
	R0 = I(R7 + 12);	//Generated by print at line: 6
	R1 = I(R7 + 8);	//Generated by print at line: 6
	R2 = I(R7 + 4);	//Generated by print at line: 6
	//if content
//end if()
L 1: 
	R1 = I(0x11ffc);	//Generated by NAME at line: 8
	R2 = I(0x11ff8);	//Generated by NAME at line: 8
	R1=R1!=R2;			// Logical - l:8
//checkCondition()
	R1 = R1 == 1;
	IF (!R1) GT(3);
	R7 = R7 - 4;		// E Generated by line 9
	R2 = 2;			// StoreOperand at line:10
	I(R6 - 8) = R2;		//Generated by line 10
//printing an ID: d
	I(R7 - 4) = R0;	//Generated by print at line: 10
	I(R7 - 8) = R1;	//Generated by print at line: 10
	I(R7 - 12) = R2;	//Generated by print at line: 10
	R7 = R7 - 16;	//Generated by print at line: 10
	R0 = 4;	//Generated by print at line: 10
	R2 = I(R6 - 8);	//Generated by print
STAT(4)	//Generated by print
	STR(0x11fec, "%i\n");	//Generated by print
CODE(4)	//Generated by print
	R1 = 0x11fec;	//Generated by print
	R0 = 4;	//Generated by print
	GT(-12);	//Generated by print
L 4:
	R0 = I(R7 + 12);	//Generated by print at line: 10
	R1 = I(R7 + 8);	//Generated by print at line: 10
	R2 = I(R7 + 4);	//Generated by print at line: 10
	//if content
//end if()
L 3: 
	R2 = I(0x11ffc);	//Generated by NAME at line: 12
	R3 = I(0x11ff8);	//Generated by NAME at line: 12
	R2=R2>R3;			// Logical - l:12
//checkCondition()
	R2 = R2 == 1;
	IF (!R2) GT(5);
	R7 = R7 - 4;		// E Generated by line 13
	R3 = 3;			// StoreOperand at line:14
	I(R6 - 12) = R3;		//Generated by line 14
//printing an ID: e
	I(R7 - 4) = R0;	//Generated by print at line: 14
	I(R7 - 8) = R1;	//Generated by print at line: 14
	I(R7 - 12) = R2;	//Generated by print at line: 14
	R7 = R7 - 16;	//Generated by print at line: 14
	R0 = 6;	//Generated by print at line: 14
	R2 = I(R6 - 12);	//Generated by print
STAT(5)	//Generated by print
	STR(0x11fe4, "%i\n");	//Generated by print
CODE(5)	//Generated by print
	R1 = 0x11fe4;	//Generated by print
	R0 = 6;	//Generated by print
	GT(-12);	//Generated by print
L 6:
	R0 = I(R7 + 12);	//Generated by print at line: 14
	R1 = I(R7 + 8);	//Generated by print at line: 14
	R2 = I(R7 + 4);	//Generated by print at line: 14
	//if content
//end if()
L 5: 
GT(-2);
END
