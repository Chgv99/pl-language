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
 R0 = 2;
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
 R0 = I(0x11ffc);
 I(R6 - 8) = R0;
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
 R0 = I(0x11ffc);
 I(R6 - 16) = R0;
 R5 = 4;
 GT(2);
L 4:
 R1 = I(R6 - 8);
 R2 = 2;
 R1=R1-R2;
 I(0x11ffc) = R1;
 R1 = I(0x11ffc);
 I(R6 - 24) = R1;
 R5 = 5;
 GT(2);
L 5:
 R1 = I(R6 - 24);
 R2 = I(R6 - 16);
 R1=R1+R2;
 I(0x11ff4) = R1;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 6;
 R2 = I(0x11ff4);
STAT(6)
 STR(0x11fe8, "%i\n");
CODE(6)
 R1 = 0x11fe8;
 R0 = 6;
 GT(-12);
L 6:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R7 = R7 + 20;
 R0 = I(R7 - 4);
 R1 = I(R7 - 8);
 R2 = I(R7 - 12);
 R5 = I(R7 - 16);

 GT(R5);
L 1:
 R5 = 7;
 GT(2);
L 7:

STAT(7)
 STR(0x11f60,"final\n");
CODE(7)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 8;
 R1 = 0x11f60;
 R2 = 0;
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
STAT(8)
 STR(0x11fd8, "%i\n");
CODE(8)
 R1 = 0x11fd8;
 R0 = 9;
 GT(-12);
L 9:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
GT(-2);
END
