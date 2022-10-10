#include "Q.h"
# 1 "<stdin>"
# 1 "<built-in>"
# 1 "<command-line>"
# 31 "<command-line>"
# 1 "/usr/include/stdc-predef.h" 1 3 4
# 32 "<command-line>" 2
# 1 "<stdin>"
# 1 "Qlib.h" 1
# 2 "<stdin>" 2
BEGIN
L 0:
STAT(0)
CODE(0)
 R7 = R7 - 4;
 R6 = R7;
STAT(1)
 DAT(0x11ffc,I,0);

CODE(1)
 R0 = 'c';


 I(0x11ffc) = R0;
STAT(2)
 DAT(0x11ff8,I,0);

CODE(2)
 R0 = 'd';


 I(0x11ff8) = R0;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 1;
 R2 = I(0x11ffc);
STAT(3)
 STR(0x11ff4, "%c\n");
CODE(3)
 R1 = 0x11ff4;
 R0 = 1;
 GT(-12);
L 1:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 2;
 R2 = I(0x11ff8);
STAT(4)
 STR(0x11fec, "%c\n");
CODE(4)
 R1 = 0x11fec;
 R0 = 2;
 GT(-12);
L 2:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R0 = I(0x11ffc);
 R1 = I(0x11ff8);
 R0=R0==R1;

 R0 = R0 == 1;
 IF (!R0) GT(3);

STAT(5)
 STR(0x11d7c,"letra1 igual que letra2\n");
CODE(5)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 4;
 R1 = 0x11d7c;
 R2 = 0;
 GT(-12);
L 4:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;


L 3:
 R0 = I(0x11ffc);
 R1 = 'c';
 R0=R0==R1;

 R0 = R0 == 1;
 IF (!R0) GT(5);

STAT(6)
 STR(0x11e74,"letra1 es c\n");
CODE(6)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 6;
 R1 = 0x11e74;
 R2 = 0;
 GT(-12);
L 6:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;


L 5:
 R0 = I(0x11ffc);
 R1 = I(0x11ff8);
 R0=R0!=R1;

 R0 = R0 == 1;
 IF (!R0) GT(7);

STAT(7)
 STR(0x11bb4,"letra1 distinta de letra2\n");
CODE(7)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 8;
 R1 = 0x11bb4;
 R2 = 0;
 GT(-12);
L 8:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;


L 7:
 R0 = I(0x11ffc);
 R1 = I(0x11ff8);
 R0=R0<R1;

 R0 = R0 == 1;
 IF (!R0) GT(9);

STAT(8)
 STR(0x11ab8,"letra1 es menor que letra2\n");
CODE(8)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 10;
 R1 = 0x11ab8;
 R2 = 0;
 GT(-12);
L 10:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;


L 9:
GT(-2);
END
