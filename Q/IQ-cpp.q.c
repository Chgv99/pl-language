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
 R0 = 1;
 I(R6 - 4) = R0;
 R7 = R7 - 8;
 R0 = 0;
 R1 = I(R6 - 4);
 R0=R0||R1;
 I(R6 - 8) = R0;
 R7 = R7 - 12;
 R0 = I(R6 - 8);
 R1 = I(R6 - 4);
 R0=R0&&R1;
 I(R6 - 12) = R0;
GT(-2);
END
