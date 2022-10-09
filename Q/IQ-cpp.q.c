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
 R0 = 1;

 I(0x11ffc) = R0;
STAT(2)
 DAT(0x11ff8,I,0);

CODE(2)
 R0 = 2;

 I(0x11ff8) = R0;
STAT(3)
 DAT(0x11ff4,I,0);

CODE(3)
 R0 = 3;

 I(0x11ff4) = R0;
STAT(4)
 DAT(0x11ff0,I,0);

CODE(4)
 R0 = 4;

 I(0x11ff0) = R0;

 GT(1);
L 3:

STAT(5)
 STR(0x11efc,"begin of test\n");
CODE(5)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 4;
 R1 = 0x11efc;
 R2 = 0;
 GT(-12);
L 4:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

 GT(2);

STAT(6)
 STR(0x11ecc,"end of test\n");
CODE(6)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 5;
 R1 = 0x11ecc;
 R2 = 0;
 GT(-12);
L 5:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

 GT(2);
L 1:

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 6;
 R2 = I(0x11ffc);
STAT(7)
 STR(0x11fdc, "%i\n");
CODE(7)
 R1 = 0x11fdc;
 R0 = 6;
 GT(-12);
L 6:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

 GT(3);
L 2:

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 8;
 R2 = I(0x11ff8);
STAT(8)
 STR(0x11fd4, "%i\n");
CODE(8)
 R1 = 0x11fd4;
 R0 = 8;
 GT(-12);
L 8:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 9;
 R2 = I(0x11ff4);
STAT(9)
 STR(0x11fcc, "%i\n");
CODE(9)
 R1 = 0x11fcc;
 R0 = 9;
 GT(-12);
L 9:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

 GT(3);
L 2:

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 11;
 R2 = I(0x11ff0);
STAT(10)
 STR(0x11fc4, "%i\n");
CODE(10)
 R1 = 0x11fc4;
 R0 = 11;
 GT(-12);
L 11:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
GT(-2);
END
