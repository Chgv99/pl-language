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
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(1);

STAT(1)
 STR(0x11ff0,"if 1\n");
CODE(1)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 2;
 R1 = 0x11ff0;
 R2 = 0;
 GT(-12);
L 2:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(3);

STAT(2)
 STR(0x11fd0,"if 2\n");
CODE(2)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 4;
 R1 = 0x11fd0;
 R2 = 0;
 GT(-12);
L 4:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(5);

STAT(3)
 STR(0x11fb0,"if 3\n");
CODE(3)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 6;
 R1 = 0x11fb0;
 R2 = 0;
 GT(-12);
L 6:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(7);

STAT(4)
 STR(0x11f90,"if 4\n");
CODE(4)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 8;
 R1 = 0x11f90;
 R2 = 0;
 GT(-12);
L 8:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(9);

STAT(5)
 STR(0x11f70,"if 5\n");
CODE(5)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 10;
 R1 = 0x11f70;
 R2 = 0;
 GT(-12);
L 10:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(11);

STAT(6)
 STR(0x11f50,"if 6\n");
CODE(6)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 12;
 R1 = 0x11f50;
 R2 = 0;
 GT(-12);
L 12:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(13);

STAT(7)
 STR(0x11f30,"if 7\n");
CODE(7)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 14;
 R1 = 0x11f30;
 R2 = 0;
 GT(-12);
L 14:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;
 R0 = 1;

 R0 = R0 == 1;
 IF (!R0) GT(15);

STAT(8)
 STR(0x11f10,"if 8\n");
CODE(8)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 16;
 R1 = 0x11f10;
 R2 = 0;
 GT(-12);
L 16:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 + 16;


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
