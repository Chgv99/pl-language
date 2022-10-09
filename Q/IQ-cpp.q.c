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
 R0 = 66;

 I(0x11ffc) = R0;

 GT(1);
L 2:
 R7 = R7 - 4;
 R0 = 33;
 I(R6 - 4) = R0;
 GT(R5);
L 1:

 I(R6 - 8) = R5;
 R7 = R7 - 4;
 R5 = 3;
 GT(2);
L 3:
 R5 = I(R6 - 8);
 R7 = R7 + 4;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 4;
 R2 = I(0x11ffc);
STAT(2)
 STR(0x11ff8, "%i\n");
CODE(2)
 R1 = 0x11ff8;
 R0 = 4;
 GT(-12);
L 4:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

STAT(3)
 STR(0x11fe0,"ey\n");
CODE(3)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 5;
 R1 = 0x11fe0;
 R2 = 0;
 GT(-12);
L 5:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
GT(-2);
END
