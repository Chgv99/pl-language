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
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(1);
 R7 = R7 - 4;
 R0 = 8;
 I(R6 - 4) = R0;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 2;
 R2 = I(R6 - 4);
STAT(2)
 STR(0x11ff8, "%i\n");
CODE(2)
 R1 = 0x11ff8;
 R0 = 2;
 GT(-12);
L 2:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(3);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 4;
 R2 = I(R6 - 4);
STAT(3)
 STR(0x11ff0, "%i\n");
CODE(3)
 R1 = 0x11ff0;
 R0 = 4;
 GT(-12);
L 4:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(5);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 6;
 R2 = I(R6 - 4);
STAT(4)
 STR(0x11fe8, "%i\n");
CODE(4)
 R1 = 0x11fe8;
 R0 = 6;
 GT(-12);
L 6:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(7);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 8;
 R2 = I(R6 - 4);
STAT(5)
 STR(0x11fe0, "%i\n");
CODE(5)
 R1 = 0x11fe0;
 R0 = 8;
 GT(-12);
L 8:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(9);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 10;
 R2 = I(R6 - 4);
STAT(6)
 STR(0x11fd8, "%i\n");
CODE(6)
 R1 = 0x11fd8;
 R0 = 10;
 GT(-12);
L 10:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(11);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 12;
 R2 = I(R6 - 4);
STAT(7)
 STR(0x11fd0, "%i\n");
CODE(7)
 R1 = 0x11fd0;
 R0 = 12;
 GT(-12);
L 12:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(13);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 14;
 R2 = I(R6 - 4);
STAT(8)
 STR(0x11fc8, "%i\n");
CODE(8)
 R1 = 0x11fc8;
 R0 = 14;
 GT(-12);
L 14:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(15);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 16;
 R2 = I(R6 - 4);
STAT(9)
 STR(0x11fc0, "%i\n");
CODE(9)
 R1 = 0x11fc0;
 R0 = 16;
 GT(-12);
L 16:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(17);

STAT(10)
 STR(0x11f70,"ey\n");
CODE(10)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 18;
 R1 = 0x11f70;
 R2 = 0;
 GT(-12);
L 18:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);


L 17:


L 15:


L 13:


L 11:


L 9:


L 7:


L 5:


L 3:


L 1:
GT(-2);
END
