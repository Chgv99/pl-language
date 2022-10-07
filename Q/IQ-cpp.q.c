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
 R0=2;
 R1=2;
 R0=R0*R1;

 I(0x11ffc) = R0;
STAT(2)
 DAT(0x11ff8,I,0);
CODE(2)
 R0=27;

 I(0x11ff8) = R0;
STAT(3)
 DAT(0x11ff4,I,0);
CODE(3)
 R0=33;

 I(0x11ff4) = R0;
STAT(4)
 DAT(0x11ff0,I,0);
CODE(4)
 R0=42;

 I(0x11ff0) = R0;
STAT(5)
 DAT(0x11fec,I,0);
CODE(5)
 R0=11;

 I(0x11fec) = R0;
STAT(6)
 DAT(0x11fe8,I,0);
CODE(6)
 R0=99;

 I(0x11fe8) = R0;
STAT(7)
 DAT(0x11fe4,I,0);
CODE(7)
 R0=115;

 I(0x11fe4) = R0;
STAT(8)
 DAT(0x11fe0,I,0);
CODE(8)
 R0=24;

 I(0x11fe0) = R0;
STAT(9)
 DAT(0x11fdc,I,0);
CODE(9)
 R0=67;

 I(0x11fdc) = R0;
STAT(10)
 DAT(0x11fd8,I,0);
CODE(10)
 R0=82;

 I(0x11fd8) = R0;
 I(R7) = R0;
 I(R7 - 4) = R1;
 I(R7 - 8) = R2;
 R7 = R7 - 12;
 R0 = 1;
 R2 = I(0x11ffc);
STAT(11)
 STR(0x11fd4, "%i\n");
CODE(11)
 R1 = 0x11fd4;
 R0 = 1;
 GT(-12);
L 1:
 R0 = I(R7);
 R1 = I(R7 + 4);
 R2 = I(R7 + 8);
 I(R7) = R0;
 I(R7 - 4) = R1;
 I(R7 - 8) = R2;
 R7 = R7 - 12;
 R0 = 2;
 R2 = I(0x11fd8);
STAT(12)
 STR(0x11fcc, "%i\n");
CODE(12)
 R1 = 0x11fcc;
 R0 = 2;
 GT(-12);
L 2:
 R0 = I(R7);
 R1 = I(R7 + 4);
 R2 = I(R7 + 8);
GT(-2);
END
