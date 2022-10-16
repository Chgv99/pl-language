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
 R0 = 20;
 I(0x11ffc) = R0;
STAT(2)
 DAT(0x11ff8,I,0);

CODE(2)
 R0 = 2;
 I(0x11ff8) = R0;
STAT(3)
 DAT(0x11ff4,I,0);

CODE(3)
STAT(4)
 DAT(0x11ff0,I,0);

CODE(4)
STAT(5)
 DAT(0x11fec,I,0);

CODE(5)

 GT(1);
L 2:
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 I(R7 - 16) = R5;
 R7 = R7 - 20;
 R7 = R7 - 4;
 R0 = I(0x11ffc);
 I(R6 - 8) = R0;
 R7 = R7 - 4;
 R0 = I(R6 - 8);
 R1 = 2;
 R1 = 2;

 R0=R0<R1;
 I(R6 - 12) = R0;
 R0 = I(R6 - 12);

 R0 = R0 == 1;
 IF (!R0) GT(3);
 R0 = I(R6 - 8);
 I(0x11ff4) = R0;

 GT(R5);


L 3:
 R0 = I(R6 - 8);
 R1 = 1;
 R0=R0-R1;
 I(0x11ffc) = R0;
 R7 = R7 - 4;
 R0 = I(0x11ffc);
 I(R6 - 16) = R0;
 R0 = I(R6 - 8);
 R1 = 2;
 R0=R0-R1;
 I(0x11ffc) = R0;
 R7 = R7 - 4;
 R0 = I(0x11ffc);
 I(R6 - 20) = R0;
 R0 = I(0x11ff0);
 R1 = I(0x11fec);
 R0=R0+R1;
 I(0x11ff4) = R0;

 GT(R5);
 R7 = R7 + 20;
 R0 = I(R7 - 4);
 R1 = I(R7 - 8);
 R2 = I(R7 - 12);
 R5 = I(R7 - 16);

 GT(R5);
L 1:
STAT(6)
 DAT(0x11fe8,I,0);

CODE(6)
 R4 = 20;
 I(R6 - 4) = R4;
L 4:
 R4 = I(R6 - 4);
 R1 = R4 > 0;
 IF (!R1) GT(5);
 R4 = R4 - 1;
 R7 = R7 - 4;
 I(R6 - 4) = R4;
 R2 = I(0x11fe8);
 I(0x11ffc) = R2;
 R5 = 6;
 GT(2);
L 6:
 R2 = I(0x11fec);
 I(0x11ff0) = R2;
 R2 = I(0x11ff4);
 I(0x11fec) = R2;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 7;
 R2 = I(0x11ff4);
STAT(7)
 STR(0x11fe4, "%i\n");
CODE(7)
 R1 = 0x11fe4;
 R0 = 7;
 GT(-12);
L 7:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R2 = I(0x11fe8);
 R3 = 1;
 R2=R2+R3;
 I(0x11fe8) = R2;
 GT(4);
L 5:
GT(-2);
END
