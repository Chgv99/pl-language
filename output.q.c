#include "Q.h"
BEGIN
L 0:						// Inicio del programa
STAT(0)	// Memoria estática
CODE(0)
	R7 = R7 - 4;
	R6 = R7;
<<<<<<< HEAD
STAT(1)		//Generated by line 1
	DAT(0x11ffc,I,0);		//Generated by line 1
//id: a
CODE(1)		//Generated by declareVar at line 1
	R0 = 1;			// StoreOperand at line:1
// pack->varType = 3, initializeVar2
	I(0x11ffc) = R0;		//Generated by line 2
STAT(2)		//Generated by line 2
	DAT(0x11ff8,I,0);		//Generated by line 2
//id: x
CODE(2)		//Generated by declareVar at line 2
	R0 = 90;			// StoreOperand at line:2
// pack->varType = 1, initializeVar3
	I(0x11ff8) = R0;		//Generated by line 3
STAT(3)		//Generated by line 3
	DAT(0x11ff4,I,0);		//Generated by line 3
//id: xx
CODE(3)		//Generated by declareVar at line 3
	R0 = 395;			// StoreOperand at line:3
// pack->varType = 1, initializeVar4
	I(0x11ff4) = R0;		//Generated by line 4
	R0 = 0;			// StoreOperand at line:4
//checkCondition()
	R0 = R0 == 1;
	IF (!R0) GT(1);
	R7 = R7 - 4;		// E Generated by line 5
	R1 = 5;			// StoreOperand at line:5
	I(R6 - 4) = R1;		//Generated by line 6
//printing an ID: xx
	I(R7 - 4) = R0;	//Generated by print at line: 6
	I(R7 - 8) = R1;	//Generated by print at line: 6
	I(R7 - 12) = R2;	//Generated by print at line: 6
	R7 = R7 - 16;	//Generated by print at line: 6
	R0 = 2;	//Generated by print at line: 6
	R2 = I(0x11ff4);	//Generated by print
STAT(4)	//Generated by print
	STR(0x11ff0, "%i\n");	//Generated by print
CODE(4)	//Generated by print
	R1 = 0x11ff0;	//Generated by print
	R0 = 2;	//Generated by print
	GT(-12);	//Generated by print
L 2:
	R0 = I(R7 + 12);	//Generated by print at line: 6
	R1 = I(R7 + 8);	//Generated by print at line: 6
	R2 = I(R7 + 4);	//Generated by print at line: 6
	R7 = R7 - 4;		// E Generated by line 7
	R1 = 6;			// StoreOperand at line:7
	I(R6 - 8) = R1;		//Generated by line 8
//printing an ID: b
	I(R7 - 4) = R0;	//Generated by print at line: 8
	I(R7 - 8) = R1;	//Generated by print at line: 8
	I(R7 - 12) = R2;	//Generated by print at line: 8
	R7 = R7 - 16;	//Generated by print at line: 8
	R0 = 3;	//Generated by print at line: 8
	R2 = I(R6 - 4);	//Generated by print
STAT(5)	//Generated by print
	STR(0x11fe8, "%i\n");	//Generated by print
CODE(5)	//Generated by print
	R1 = 0x11fe8;	//Generated by print
	R0 = 3;	//Generated by print
	GT(-12);	//Generated by print
L 3:
	R0 = I(R7 + 12);	//Generated by print at line: 8
	R1 = I(R7 + 8);	//Generated by print at line: 8
	R2 = I(R7 + 4);	//Generated by print at line: 8
//printing an ID: x
	I(R7 - 4) = R0;	//Generated by print at line: 9
	I(R7 - 8) = R1;	//Generated by print at line: 9
	I(R7 - 12) = R2;	//Generated by print at line: 9
	R7 = R7 - 16;	//Generated by print at line: 9
	R0 = 4;	//Generated by print at line: 9
	R2 = I(R6 - 8);	//Generated by print
STAT(6)	//Generated by print
	STR(0x11fe0, "%i\n");	//Generated by print
CODE(6)	//Generated by print
	R1 = 0x11fe0;	//Generated by print
	R0 = 4;	//Generated by print
	GT(-12);	//Generated by print
L 4:
	R0 = I(R7 + 12);	//Generated by print at line: 9
	R1 = I(R7 + 8);	//Generated by print at line: 9
	R2 = I(R7 + 4);	//Generated by print at line: 9
	//if content
//end if()
L 1: 
//printing an ID: x
	I(R7 - 4) = R0;	//Generated by print at line: 11
	I(R7 - 8) = R1;	//Generated by print at line: 11
	I(R7 - 12) = R2;	//Generated by print at line: 11
	R7 = R7 - 16;	//Generated by print at line: 11
	R0 = 5;	//Generated by print at line: 11
	R2 = I(0x11ff8);	//Generated by print
STAT(7)	//Generated by print
	STR(0x11fd8, "%i\n");	//Generated by print
CODE(7)	//Generated by print
	R1 = 0x11fd8;	//Generated by print
	R0 = 5;	//Generated by print
	GT(-12);	//Generated by print
L 5:
	R0 = I(R7 + 12);	//Generated by print at line: 11
	R1 = I(R7 + 8);	//Generated by print at line: 11
	R2 = I(R7 + 4);	//Generated by print at line: 11
//printing a STR: Resultado: 
STAT(8)	//Generated by print
	STR(0x11df0,"Resultado: \n");		//Generated by line 12
CODE(8)	//Generated by print
	I(R7 - 4) = R0;	//Generated by print at line: 12
	I(R7 - 8) = R1;	//Generated by print at line: 12
	I(R7 - 12) = R2;	//Generated by print at line: 12
	R7 = R7 - 16;	//Generated by print at line: 12
	R0 = 6;		//Generated by line 12
	R1 = 0x11df0;		//Generated by line 12
	R2 = 0;		//Generated by line 12
	GT(-12);	//Generated by print
L 6:
	R0 = I(R7 + 12);	//Generated by print at line: 12
	R1 = I(R7 + 8);	//Generated by print at line: 12
	R2 = I(R7 + 4);	//Generated by print at line: 12
//printing a STR: 3
STAT(9)	//Generated by print
	STR(0x11fc8,"3\n");		//Generated by line 13
CODE(9)	//Generated by print
	I(R7 - 4) = R0;	//Generated by print at line: 13
	I(R7 - 8) = R1;	//Generated by print at line: 13
	I(R7 - 12) = R2;	//Generated by print at line: 13
	R7 = R7 - 16;	//Generated by print at line: 13
	R0 = 7;		//Generated by line 13
	R1 = 0x11fc8;		//Generated by line 13
	R2 = 0;		//Generated by line 13
	GT(-12);	//Generated by print
L 7:
	R0 = I(R7 + 12);	//Generated by print at line: 13
	R1 = I(R7 + 8);	//Generated by print at line: 13
	R2 = I(R7 + 4);	//Generated by print at line: 13
//printing an ID: a
	I(R7 - 4) = R0;	//Generated by print at line: 14
	I(R7 - 8) = R1;	//Generated by print at line: 14
	I(R7 - 12) = R2;	//Generated by print at line: 14
	R7 = R7 - 16;	//Generated by print at line: 14
	R0 = 8;	//Generated by print at line: 14
	R2 = I(0x11ffc);	//Generated by print
STAT(10)	//Generated by print
	STR(0x11fc0, "%i\n");	//Generated by print
CODE(10)	//Generated by print
	R1 = 0x11fc0;	//Generated by print
	R0 = 8;	//Generated by print
	GT(-12);	//Generated by print
L 8:
	R0 = I(R7 + 12);	//Generated by print at line: 14
	R1 = I(R7 + 8);	//Generated by print at line: 14
	R2 = I(R7 + 4);	//Generated by print at line: 14
=======
	R7 = R7 - 4;		//Generated by line 2
	R0 = 1;			// StoreOperand at line:2
	I(R6 - 4) = R0;		//Generated by line 3
	R7 = R7 - 8;		//Generated by line 3
	R0 = 0;			// StoreOperand at line:3
	R1 = I(R6 - 4);	//Generated by NAME at line: 3
	R0=R0||R1;			// Logical - l:4
	I(R6 - 8) = R0;		//Generated by line 4
	R7 = R7 - 12;		//Generated by line 4
	R0 = I(R6 - 8);	//Generated by NAME at line: 4
	R1 = I(R6 - 4);	//Generated by NAME at line: 4
	R0=R0&&R1;			// Logical - l:5
	I(R6 - 12) = R0;		//Generated by line 5
>>>>>>> variables
GT(-2);
END
