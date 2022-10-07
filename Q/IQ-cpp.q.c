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
 R7 = R7 - 4;
 R0=13;

 I(R6 - 4) = R0;
 I(R7) = R0;
 I(R7 - 4) = R1;
 I(R7 - 8) = R2;
 R7 = R7 - 12;
 R0 = 1;
 R2 = I(R6 - 4);
STAT(1)
 STR(0x11ffc, "%i\n");
CODE(1)
 R1 = 0x11ffc;
 R0 = 1;
 GT(-12);
L 1:
 R0 = I(R7);
 R1 = I(R7 - 4);
 R2 = I(R7 - 8);
 R7 = R7 - 8;
 R0=8;

 I(R6 - 8) = R0;
 I(R7) = R0;
 I(R7 - 4) = R1;
 I(R7 - 8) = R2;
 R7 = R7 - 12;
 R0 = 2;
 R2 = I(R6 - 8);
STAT(2)
 STR(0x11ff4, "%i\n");
CODE(2)
 R1 = 0x11ff4;
 R0 = 2;
 GT(-12);
L 2:
 R0 = I(R7);
 R1 = I(R7 - 4);
 R2 = I(R7 - 8);
 R7 = R7 - 12;
 R0=25;

 I(R6 - 12) = R0;
 I(R7) = R0;
 I(R7 - 4) = R1;
 I(R7 - 8) = R2;
 R7 = R7 - 12;
 R0 = 3;
 R2 = I(R6 - 12);
STAT(3)
 STR(0x11fec, "%i\n");
CODE(3)
 R1 = 0x11fec;
 R0 = 3;
 GT(-12);
L 3:
 R0 = I(R7);
 R1 = I(R7 - 4);
 R2 = I(R7 - 8);
GT(-2);
END
