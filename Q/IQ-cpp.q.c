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
 R0 = 3;


 I(0x11ffc) = R0;
STAT(2)
 DAT(0x11ff8,I,0);

CODE(2)
 R0 = 5;


 I(0x11ff8) = R0;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 1;
 R2 = I(0x11ffc);
STAT(3)
 STR(0x11ff4, "%i\n");
CODE(3)
 R1 = 0x11ff4;
 R0 = 1;
 GT(-12);
L 1:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
STAT(4)
 DAT(0x11fec,I,0);

CODE(4)
 R0 = 3;
 R1 = 5;
 R0=R0+R1;


 I(0x11fec) = R0;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 2;
 R2 = I(0x11ff8);
STAT(5)
 STR(0x11fe8, "%i\n");
CODE(5)
 R1 = 0x11fe8;
 R0 = 2;
 GT(-12);
L 2:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
STAT(6)
 DAT(0x11fe0,I,0);

CODE(6)
 R0 = 1;


 I(0x11fe0) = R0;
STAT(7)
 DAT(0x11fdc,I,0);

CODE(7)
 R0 = 1;
 R1 = 0;
 R0=R0&&R1;
 R0=!R0;


 I(0x11fdc) = R0;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 3;
 R2 = I(0x11fec);
STAT(8)
 STR(0x11fd8, "%i\n");
CODE(8)
 R1 = 0x11fd8;
 R0 = 3;
 GT(-12);
L 3:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 4;
 R2 = I(0x11fe0);
STAT(9)
 STR(0x11fd0, "%i\n");
CODE(9)
 R1 = 0x11fd0;
 R0 = 4;
 GT(-12);
L 4:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 5;
 R2 = I(0x11fdc);
STAT(10)
 STR(0x11fc8, "%i\n");
CODE(10)
 R1 = 0x11fc8;
 R0 = 5;
 GT(-12);
L 5:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
GT(-2);
END
