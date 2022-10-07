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
 R0=8;

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
GT(-2);
END
