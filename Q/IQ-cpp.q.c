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
<<<<<<< HEAD
STAT(1)
 DAT(0x11ffc,I,0);

CODE(1)
 R0 = 1;

 I(0x11ffc) = R0;
STAT(2)
 DAT(0x11ff8,I,0);

CODE(2)
 R0 = 90;

 I(0x11ff8) = R0;
STAT(3)
 DAT(0x11ff4,I,0);

CODE(3)
 R0 = 395;

 I(0x11ff4) = R0;
 R0 = 0;

 R0 = R0 == 1;
 IF (!R0) GT(1);
 R7 = R7 - 4;
 R1 = 5;
 I(R6 - 4) = R1;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 2;
 R2 = I(0x11ff4);
STAT(4)
 STR(0x11ff0, "%i\n");
CODE(4)
 R1 = 0x11ff0;
 R0 = 2;
 GT(-12);
L 2:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
 R7 = R7 - 4;
 R1 = 6;
 I(R6 - 8) = R1;

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 3;
 R2 = I(R6 - 4);
STAT(5)
 STR(0x11fe8, "%i\n");
CODE(5)
 R1 = 0x11fe8;
 R0 = 3;
 GT(-12);
L 3:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 4;
 R2 = I(R6 - 8);
STAT(6)
 STR(0x11fe0, "%i\n");
CODE(6)
 R1 = 0x11fe0;
 R0 = 4;
 GT(-12);
L 4:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);


L 1:

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 5;
 R2 = I(0x11ff8);
STAT(7)
 STR(0x11fd8, "%i\n");
CODE(7)
 R1 = 0x11fd8;
 R0 = 5;
 GT(-12);
L 5:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);

STAT(8)
 STR(0x11df0,"Resultado: \n");
CODE(8)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 6;
 R1 = 0x11df0;
 R2 = 0;
 GT(-12);
L 6:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);

STAT(9)
 STR(0x11fc8,"3\n");
CODE(9)
 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 7;
 R1 = 0x11fc8;
 R2 = 0;
 GT(-12);
L 7:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);

 I(R7 - 4) = R0;
 I(R7 - 8) = R1;
 I(R7 - 12) = R2;
 R7 = R7 - 16;
 R0 = 8;
 R2 = I(0x11ffc);
STAT(10)
 STR(0x11fc0, "%i\n");
CODE(10)
 R1 = 0x11fc0;
 R0 = 8;
 GT(-12);
L 8:
 R0 = I(R7 + 12);
 R1 = I(R7 + 8);
 R2 = I(R7 + 4);
=======
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
>>>>>>> variables
GT(-2);
END
