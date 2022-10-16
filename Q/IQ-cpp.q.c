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
 R0 = 2;
 I(0x11ff8) = R0;
STAT(3)
 DAT(0x11ff4,I,0);

CODE(3)
 R0 = I(0x11ffc);
 R1 = I(0x11ff8);
 R0=R0+R1;
 I(0x11ff4) = R0;
STAT(4)
 DAT(0x11ff0,I,0);

CODE(4)
 RR0 = 5.000000;
 F(0x11ff0) = RR0;
STAT(5)
 DAT(0x11fec,I,0);

CODE(5)
 RR0 = 3.500000;
 F(0x11fec) = RR0;
STAT(6)
 DAT(0x11fe8,I,0);

CODE(6)
 R0 = 1;
 I(0x11fe8) = R0;
STAT(7)
 DAT(0x11fe4,I,0);

CODE(7)
 R0 = 1;
 R1 = 0;
 R0=R0||R1;
 I(0x11fe4) = R0;
STAT(8)
 DAT(0x11fe0,I,0);

CODE(8)
 R0 = 'Z';
 I(0x11fe0) = R0;
STAT(9)
 DAT(0x11fdc,I,0);

CODE(9)
 RR0 = 3.500000;

GT(-2);
END
