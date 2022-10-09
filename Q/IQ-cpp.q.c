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
 R0 = 13;

 I(0x11ffc) = R0;

 GT(2);
L 1:

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 3;
 R2 = I(0x11ffc);
STAT(2)
 STR(0x11ff4, "%i\n");
CODE(2)
 R1 = 0x11ff4;
 R0 = 3;
 GT(-12);
L 3:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 I(0x11fec) = 4;
 GT(4);
L 2:

 R0 = I(0x11fec);
L R0:
GT(-2);
END
