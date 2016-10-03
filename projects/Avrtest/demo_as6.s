00000000  JMP 0x00000038		Jump 
00000002  JMP 0x00000042		Jump 
00000004  JMP 0x00000042		Jump 
00000006  JMP 0x00000042		Jump 
00000008  JMP 0x00000042		Jump 
0000000A  JMP 0x00000042		Jump 
0000000C  JMP 0x00000042		Jump 
0000000E  JMP 0x00000042		Jump 
00000010  JMP 0x00000042		Jump 
00000012  JMP 0x00000042		Jump 
00000014  JMP 0x00000042		Jump 
00000016  JMP 0x00000042		Jump 
00000018  JMP 0x00000042		Jump 
0000001A  JMP 0x00000042		Jump 
0000001C  JMP 0x00000042		Jump 
0000001E  JMP 0x00000042		Jump 
00000020  JMP 0x00000042		Jump 
00000022  JMP 0x00000042		Jump 
00000024  JMP 0x00000042		Jump 
00000026  JMP 0x00000042		Jump 
00000028  JMP 0x00000042		Jump 
0000002A  JMP 0x00000042		Jump 
0000002C  JMP 0x00000042		Jump 
0000002E  JMP 0x00000042		Jump 
00000030  JMP 0x00000042		Jump 
00000032  JMP 0x00000042		Jump 
00000034  JMP 0x00000042		Jump 
00000036  JMP 0x00000042		Jump 
00000038  CLR R1		Clear Register 
00000039  OUT 0x3F,R1		Out to I/O location 
0000003A  SER R28		Set Register 
0000003B  LDI R29,0x10		Load immediate 
0000003C  OUT 0x3E,R29		Out to I/O location 
0000003D  OUT 0x3D,R28		Out to I/O location 
0000003E  CALL 0x00000044		Call subroutine 
00000040  JMP 0x0000009A		Jump 
00000042  JMP 0x00000000		Jump 
--- D:\zjn\Dropbox\Research\BitGuard\projects\Avrtest_2\Avrtest_2\Debug/.././demo.c 
{ 
00000044  PUSH R28		Push register on stack 
00000045  PUSH R29		Push register on stack 
00000046  RCALL PC+0x0001		Relative call subroutine 
00000047  RCALL PC+0x0001		Relative call subroutine 
00000048  IN R28,0x3D		In from I/O location 
00000049  IN R29,0x3E		In from I/O location 
    i=1;
0000004A  LDI R24,0x01		Load immediate 
0000004B  LDI R25,0x00		Load immediate 
0000004C  STD Y+2,R25		Store indirect with displacement 
0000004D  STD Y+1,R24		Store indirect with displacement 
    j=300; 
0000004E  LDI R24,0x2C		Load immediate 
0000004F  LDI R25,0x01		Load immediate 
00000050  STD Y+4,R25		Store indirect with displacement 
00000051  STD Y+3,R24		Store indirect with displacement 
    foo(1, i, j);   
00000052  LDD R18,Y+3		Load indirect with displacement 
00000053  LDD R19,Y+4		Load indirect with displacement 
00000054  LDD R24,Y+1		Load indirect with displacement 
00000055  LDD R25,Y+2		Load indirect with displacement 
00000056  MOVW R20,R18		Copy register pair 
00000057  MOVW R22,R24		Copy register pair 
00000058  LDI R24,0x01		Load immediate 
00000059  CALL 0x00000064		Call subroutine 
    return 0; 
0000005B  LDI R24,0x00		Load immediate 
--- D:\zjn\Dropbox\Research\BitGuard\projects\Avrtest_2\Avrtest_2\Debug/.././demo.c 
0000005C  LDI R25,0x00		Load immediate 
}
0000005D  POP R0		Pop register from stack 
0000005E  POP R0		Pop register from stack 
0000005F  POP R0		Pop register from stack 
00000060  POP R0		Pop register from stack 
00000061  POP R29		Pop register from stack 
00000062  POP R28		Pop register from stack 
00000063  RET 		Subroutine return 
{   
00000064  PUSH R28		Push register on stack 
00000065  PUSH R29		Push register on stack 
00000066  IN R28,0x3D		In from I/O location 
00000067  IN R29,0x3E		In from I/O location 
00000068  SBIW R28,0x0B		Subtract immediate from word 
00000069  IN R0,0x3F		In from I/O location 
0000006A  CLI 		Global Interrupt Disable 
0000006B  OUT 0x3E,R29		Out to I/O location 
0000006C  OUT 0x3F,R0		Out to I/O location 
0000006D  OUT 0x3D,R28		Out to I/O location 
0000006E  STD Y+7,R24		Store indirect with displacement 
0000006F  STD Y+9,R23		Store indirect with displacement 
00000070  STD Y+8,R22		Store indirect with displacement 
00000071  STD Y+11,R21		Store indirect with displacement 
00000072  STD Y+10,R20		Store indirect with displacement 
    x=a+b;
00000073  LDD R24,Y+7		Load indirect with displacement 
00000074  MOV R18,R24		Copy register 
00000075  LDI R19,0x00		Load immediate 
00000076  LDD R24,Y+8		Load indirect with displacement 
00000077  LDD R25,Y+9		Load indirect with displacement 
00000078  ADD R24,R18		Add without carry 
00000079  ADC R25,R19		Add with carry 
--- D:\zjn\Dropbox\Research\BitGuard\projects\Avrtest_2\Avrtest_2\Debug/.././demo.c 
0000007A  STD Y+2,R25		Store indirect with displacement 
0000007B  STD Y+1,R24		Store indirect with displacement 
    y=c-a;
0000007C  LDD R24,Y+7		Load indirect with displacement 
0000007D  MOV R24,R24		Copy register 
0000007E  LDI R25,0x00		Load immediate 
0000007F  LDD R18,Y+10		Load indirect with displacement 
00000080  LDD R19,Y+11		Load indirect with displacement 
00000081  MOVW R20,R18		Copy register pair 
00000082  SUB R20,R24		Subtract without carry 
00000083  SBC R21,R25		Subtract with carry 
00000084  MOVW R24,R20		Copy register pair 
00000085  STD Y+4,R25		Store indirect with displacement 
00000086  STD Y+3,R24		Store indirect with displacement 
    z=x+y;
00000087  LDD R18,Y+1		Load indirect with displacement 
00000088  LDD R19,Y+2		Load indirect with displacement 
00000089  LDD R24,Y+3		Load indirect with displacement 
0000008A  LDD R25,Y+4		Load indirect with displacement 
0000008B  ADD R24,R18		Add without carry 
0000008C  ADC R25,R19		Add with carry 
0000008D  STD Y+6,R25		Store indirect with displacement 
0000008E  STD Y+5,R24		Store indirect with displacement 
    return z;
0000008F  LDD R24,Y+5		Load indirect with displacement 
00000090  LDD R25,Y+6		Load indirect with displacement 
}
00000091  ADIW R28,0x0B		Add immediate to word 
00000092  IN R0,0x3F		In from I/O location 
00000093  CLI 		Global Interrupt Disable 
00000094  OUT 0x3E,R29		Out to I/O location 
00000095  OUT 0x3F,R0		Out to I/O location 
00000096  OUT 0x3D,R28		Out to I/O location 
00000097  POP R29		Pop register from stack 
--- D:\zjn\Dropbox\Research\BitGuard\projects\Avrtest_2\Avrtest_2\Debug/.././demo.c 
00000098  POP R28		Pop register from stack 
00000099  RET 		Subroutine return 
--- No source file -------------------------------------------------------------
0000009A  CLI 		Global Interrupt Disable 
0000009B  RJMP PC-0x0000		Relative jump 
0000009C  NOP 		Undefined 
0000009D  NOP 		Undefined 
0000009E  NOP 		Undefined 
0000009F  NOP 		Undefined 
000000A0  NOP 		Undefined 
000000A1  NOP 		Undefined 
000000A2  NOP 		Undefined 
000000A3  NOP 		Undefined 
000000A4  NOP 		Undefined 
000000A5  NOP 		Undefined 
000000A6  NOP 		Undefined 
000000A7  NOP 		Undefined 
000000A8  NOP 		Undefined 
000000A9  NOP 		Undefined 
000000AA  NOP 		Undefined 
000000AB  NOP 		Undefined 
000000AC  NOP 		Undefined 
000000AD  NOP 		Undefined 
000000AE  NOP 		Undefined 
000000AF  NOP 		Undefined 
000000B0  NOP 		Undefined 
000000B1  NOP 		Undefined 
000000B2  NOP 		Undefined 
000000B3  NOP 		Undefined 
000000B4  NOP 		Undefined 
000000B5  NOP 		Undefined 
--- No source file -------------------------------------------------------------
000000B6  NOP 		Undefined 
000000B7  NOP 		Undefined 
000000B8  NOP 		Undefined 
000000B9  NOP 		Undefined 
000000BA  NOP 		Undefined 
000000BB  NOP 		Undefined 
000000BC  NOP 		Undefined 
000000BD  NOP 		Undefined 
000000BE  NOP 		Undefined 
000000BF  NOP 		Undefined 
000000C0  NOP 		Undefined 
000000C1  NOP 		Undefined 
000000C2  NOP 		Undefined 
000000C3  NOP 		Undefined 
000000C4  NOP 		Undefined 
000000C5  NOP 		Undefined 
000000C6  NOP 		Undefined 
000000C7  NOP 		Undefined 
000000C8  NOP 		Undefined 
000000C9  NOP 		Undefined 
000000CA  NOP 		Undefined 
000000CB  NOP 		Undefined 
000000CC  NOP 		Undefined 
000000CD  NOP 		Undefined 
000000CE  NOP 		Undefined 
000000CF  NOP 		Undefined 
000000D0  NOP 		Undefined 
000000D1  NOP 		Undefined 
000000D2  NOP 		Undefined 
000000D3  NOP 		Undefined 
000000D4  NOP 		Undefined 
000000D5  NOP 		Undefined 
000000D6  NOP 		Undefined 
000000D7  NOP 		Undefined 
000000D8  NOP 		Undefined 
000000D9  NOP 		Undefined 
000000DA  NOP 		Undefined 
000000DB  NOP 		Undefined 
--- No source file -------------------------------------------------------------
000000DC  NOP 		Undefined 
000000DD  NOP 		Undefined 
000000DE  NOP 		Undefined 
000000DF  NOP 		Undefined 
000000E0  NOP 		Undefined 
000000E1  NOP 		Undefined 
000000E2  NOP 		Undefined 
000000E3  NOP 		Undefined 
000000E4  NOP 		Undefined 
000000E5  NOP 		Undefined 
000000E6  NOP 		Undefined 
000000E7  NOP 		Undefined 
000000E8  NOP 		Undefined 
000000E9  NOP 		Undefined 
000000EA  NOP 		Undefined 
000000EB  NOP 		Undefined 
000000EC  NOP 		Undefined 
000000ED  NOP 		Undefined 
000000EE  NOP 		Undefined 
000000EF  NOP 		Undefined 
000000F0  NOP 		Undefined 
000000F1  NOP 		Undefined 
000000F2  NOP 		Undefined 
000000F3  NOP 		Undefined 
000000F4  NOP 		Undefined 
000000F5  NOP 		Undefined 
000000F6  NOP 		Undefined 
000000F7  NOP 		Undefined 
000000F8  NOP 		Undefined 
000000F9  NOP 		Undefined 
000000FA  NOP 		Undefined 
000000FB  NOP 		Undefined 
000000FC  NOP 		Undefined 
000000FD  NOP 		Undefined 
000000FE  NOP 		Undefined 
000000FF  NOP 		Undefined 
00000100  NOP 		Undefined 
00000101  NOP 		Undefined 
--- No source file -------------------------------------------------------------
00000102  NOP 		Undefined 
00000103  NOP 		Undefined 
00000104  NOP 		Undefined 
00000105  NOP 		Undefined 
00000106  NOP 		Undefined 
00000107  NOP 		Undefined 
00000108  NOP 		Undefined 
00000109  NOP 		Undefined 
0000010A  NOP 		Undefined 
0000010B  NOP 		Undefined 
0000010C  NOP 		Undefined 
0000010D  NOP 		Undefined 
0000010E  NOP 		Undefined 
0000010F  NOP 		Undefined 
00000110  NOP 		Undefined 
00000111  NOP 		Undefined 
00000112  NOP 		Undefined 
00000113  NOP 		Undefined 
00000114  NOP 		Undefined 
00000115  NOP 		Undefined 
00000116  NOP 		Undefined 
00000117  NOP 		Undefined 
00000118  NOP 		Undefined 
00000119  NOP 		Undefined 
0000011A  NOP 		Undefined 
0000011B  NOP 		Undefined 
0000011C  NOP 		Undefined 
0000011D  NOP 		Undefined 
0000011E  NOP 		Undefined 
0000011F  NOP 		Undefined 
00000120  NOP 		Undefined 
00000121  NOP 		Undefined 
00000122  NOP 		Undefined 
00000123  NOP 		Undefined 
00000124  NOP 		Undefined 
00000125  NOP 		Undefined 
00000126  NOP 		Undefined 
00000127  NOP 		Undefined 
--- No source file -------------------------------------------------------------
00000128  NOP 		Undefined 
00000129  NOP 		Undefined 
0000012A  NOP 		Undefined 
0000012B  NOP 		Undefined 
0000012C  NOP 		Undefined 
0000012D  NOP 		Undefined 
0000012E  NOP 		Undefined 
0000012F  NOP 		Undefined 
00000130  NOP 		Undefined 
00000131  NOP 		Undefined 
00000132  NOP 		Undefined 
00000133  NOP 		Undefined 
00000134  NOP 		Undefined 
00000135  NOP 		Undefined 
00000136  NOP 		Undefined 
00000137  NOP 		Undefined 
00000138  NOP 		Undefined 
00000139  NOP 		Undefined 
0000013A  NOP 		Undefined 
0000013B  NOP 		Undefined 
0000013C  NOP 		Undefined 
0000013D  NOP 		Undefined 
0000013E  NOP 		Undefined 
0000013F  NOP 		Undefined 
00000140  NOP 		Undefined 
00000141  NOP 		Undefined 
00000142  NOP 		Undefined 
00000143  NOP 		Undefined 
00000144  NOP 		Undefined 
00000145  NOP 		Undefined 
00000146  NOP 		Undefined 
00000147  NOP 		Undefined 
00000148  NOP 		Undefined 
00000149  NOP 		Undefined 
0000014A  NOP 		Undefined 
0000014B  NOP 		Undefined 
0000014C  NOP 		Undefined 
0000014D  NOP 		Undefined 