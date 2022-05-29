/* A Bison parser, made by GNU Bison 3.5.1.  */

/* Bison interface for Yacc-like parsers in C

   Copyright (C) 1984, 1989-1990, 2000-2015, 2018-2020 Free Software Foundation,
   Inc.

   This program is free software: you can redistribute it and/or modify
   it under the terms of the GNU General Public License as published by
   the Free Software Foundation, either version 3 of the License, or
   (at your option) any later version.

   This program is distributed in the hope that it will be useful,
   but WITHOUT ANY WARRANTY; without even the implied warranty of
   MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
   GNU General Public License for more details.

   You should have received a copy of the GNU General Public License
   along with this program.  If not, see <http://www.gnu.org/licenses/>.  */

/* As a special exception, you may create a larger work that contains
   part or all of the Bison parser skeleton and distribute that work
   under terms of your choice, so long as that work isn't itself a
   parser generator using the skeleton or a modified version thereof
   as a parser skeleton.  Alternatively, if you modify or redistribute
   the parser skeleton itself, you may (at your option) remove this
   special exception, which will cause the skeleton and the resulting
   Bison output files to be licensed under the GNU General Public
   License without this special exception.

   This special exception was added by the Free Software Foundation in
   version 2.2 of Bison.  */

/* Undocumented macros, especially those whose name start with YY_,
   are private implementation details.  Do not rely on them.  */

#ifndef YY_YY_Y_TAB_H_INCLUDED
# define YY_YY_Y_TAB_H_INCLUDED
/* Debug traces.  */
#ifndef YYDEBUG
# define YYDEBUG 0
#endif
#if YYDEBUG
extern int yydebug;
#endif

/* Token type.  */
#ifndef YYTOKENTYPE
# define YYTOKENTYPE
  enum yytokentype
  {
    DIGIT = 258,
    INC = 259,
    DEC = 260,
    MULT_ASSIGN = 261,
    DIV_ASSIGN = 262,
    LEARN = 263,
    ARROW = 264,
    RET = 265,
    END = 266,
    NEXT = 267,
    TERM = 268,
    INT = 269,
    FLOAT = 270,
    BOOL = 271,
    CHAR = 272,
    VOID = 273,
    ARR = 274,
    STR = 275,
    V_INT = 276,
    V_FLOAT = 277,
    V_BOOL = 278,
    V_CHAR = 279,
    V_VOID = 280,
    V_ARR = 281,
    V_STR = 282,
    NAME = 283,
    COMM = 284,
    RANGE = 285,
    LEN = 286,
    PRINT = 287,
    METH = 288,
    IF = 289,
    AND = 290,
    OR = 291,
    NOT = 292,
    ELSE = 293,
    LOOP = 294,
    FOR = 295,
    WHILE = 296,
    UNTIL = 297,
    EQ = 298,
    NEQ = 299,
    GT = 300,
    LT = 301,
    GTE = 302,
    LTE = 303,
    TRUE = 304,
    FALSE = 305
  };
#endif
/* Tokens.  */
#define DIGIT 258
#define INC 259
#define DEC 260
#define MULT_ASSIGN 261
#define DIV_ASSIGN 262
#define LEARN 263
#define ARROW 264
#define RET 265
#define END 266
#define NEXT 267
#define TERM 268
#define INT 269
#define FLOAT 270
#define BOOL 271
#define CHAR 272
#define VOID 273
#define ARR 274
#define STR 275
#define V_INT 276
#define V_FLOAT 277
#define V_BOOL 278
#define V_CHAR 279
#define V_VOID 280
#define V_ARR 281
#define V_STR 282
#define NAME 283
#define COMM 284
#define RANGE 285
#define LEN 286
#define PRINT 287
#define METH 288
#define IF 289
#define AND 290
#define OR 291
#define NOT 292
#define ELSE 293
#define LOOP 294
#define FOR 295
#define WHILE 296
#define UNTIL 297
#define EQ 298
#define NEQ 299
#define GT 300
#define LT 301
#define GTE 302
#define LTE 303
#define TRUE 304
#define FALSE 305

/* Value type.  */
#if ! defined YYSTYPE && ! defined YYSTYPE_IS_DECLARED
typedef int YYSTYPE;
# define YYSTYPE_IS_TRIVIAL 1
# define YYSTYPE_IS_DECLARED 1
#endif


extern YYSTYPE yylval;

int yyparse (void);

#endif /* !YY_YY_Y_TAB_H_INCLUDED  */
