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
 R6 = R7;
STAT(1)
 DAT(0x11ffc,I,0);
CODE(1)
 R0=R0*R1;
 R1 = 0x11ffc;
 R0 = R0;
 I(R1) = R0;
STAT(2)
 DAT(0x11ff8,I,0);
CODE(2)
 I(R7) = R0;
 I(R7 - 4) = R1;
 I(R7 - 8) = R2;
 R7 = R7 - 12;
 R0 = 1;
 R2 = I(0x11ffc);
STAT(3)
 STR(0x11ff4, "%i\n");
CODE(3)
 R1 = 0x11ff4;
 R0 = 1;
 GT(-12);
L 1:
 R0 = I(R7);
 R1 = I(R7 - 4);
 R2 = I(R7 - 8);
 I(R7) = R0;
 I(R7 - 4) = R1;
 I(R7 - 8) = R2;
 R7 = R7 - 12;
 R0 = 2;
 R2 = I(0x11ff8);
STAT(4)
 STR(0x11fec, "%i\n");
CODE(4)
 R1 = 0x11fec;
 R0 = 2;
 GT(-12);
L 2:
 R0 = I(R7);
 R1 = I(R7 - 4);
 R2 = I(R7 - 8);
 R7 = R7 - 4;
 R0 = R1;
 I(R7) = R0;
GT(-2);
END
