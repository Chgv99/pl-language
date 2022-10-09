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
STAT(2)
 DAT(0x11ff8,I,0);

CODE(2)
 R0 = 8;

 I(0x11ff8) = R0;
STAT(3)
 DAT(0x11ff4,I,0);

CODE(3)
 R0 = 'd';

 I(0x11ff4) = R0;
 R0 = 'd';
 R1 = I(0x11ff4);
 R0=R0==R1;

 R0 = R0 == 1;
 IF (!R0) GT(1);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 2;
 R2 = I(0x11ff4);
STAT(4)
 STR(0x11ff0, "%c\n");
CODE(4)
 R1 = 0x11ff0;
 R0 = 2;
 GT(-12);
L 2:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;


L 1:
GT(-2);
END
