	.file	"test1.c"
	.arch atmega16
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
	.stabs	"../test1.c",100,0,2,.Ltext0
	.text
.Ltext0:
	.stabs	"gcc2_compiled.",60,0,0,0
	.stabs	"int:t(0,1)=r(0,1);-32768;32767;",128,0,0,0
	.stabs	"char:t(0,2)=r(0,2);0;255;",128,0,0,0
	.stabs	"long int:t(0,3)=r(0,3);-2147483648;2147483647;",128,0,0,0
	.stabs	"unsigned int:t(0,4)=r(0,4);0;65535;",128,0,0,0
	.stabs	"long unsigned int:t(0,5)=r(0,5);0;4294967295;",128,0,0,0
	.stabs	"long long int:t(0,6)=r(0,6);-0;4294967295;",128,0,0,0
	.stabs	"long long unsigned int:t(0,7)=r(0,7);0;-1;",128,0,0,0
	.stabs	"short int:t(0,8)=r(0,8);-32768;32767;",128,0,0,0
	.stabs	"short unsigned int:t(0,9)=r(0,9);0;65535;",128,0,0,0
	.stabs	"signed char:t(0,10)=r(0,10);-128;127;",128,0,0,0
	.stabs	"unsigned char:t(0,11)=r(0,11);0;255;",128,0,0,0
	.stabs	"float:t(0,12)=r(0,1);4;0;",128,0,0,0
	.stabs	"double:t(0,13)=r(0,1);4;0;",128,0,0,0
	.stabs	"long double:t(0,14)=r(0,1);4;0;",128,0,0,0
	.stabs	"void:t(0,15)=(0,15)",128,0,0,0
	.stabs	"/usr/bin/../lib/gcc/avr/4.1.2/../../../../avr/include/avr/io.h",130,0,0,0
	.stabs	"/usr/bin/../lib/gcc/avr/4.1.2/../../../../avr/include/avr/sfr_defs.h",130,0,0,0
	.stabs	"/usr/bin/../lib/gcc/avr/4.1.2/../../../../avr/include/inttypes.h",130,0,0,0
	.stabs	"/usr/bin/../lib/gcc/avr/4.1.2/../../../../avr/include/stdint.h",130,0,0,0
	.stabs	"int8_t:t(4,1)=(0,10)",128,0,0,0
	.stabs	"uint8_t:t(4,2)=(0,11)",128,0,0,0
	.stabs	"int16_t:t(4,3)=(0,1)",128,0,0,0
	.stabs	"uint16_t:t(4,4)=(0,4)",128,0,0,0
	.stabs	"int32_t:t(4,5)=(0,3)",128,0,0,0
	.stabs	"uint32_t:t(4,6)=(0,5)",128,0,0,0
	.stabs	"int64_t:t(4,7)=(0,6)",128,0,0,0
	.stabs	"uint64_t:t(4,8)=(0,7)",128,0,0,0
	.stabs	"intptr_t:t(4,9)=(4,3)",128,0,0,0
	.stabs	"uintptr_t:t(4,10)=(4,4)",128,0,0,0
	.stabs	"int_least8_t:t(4,11)=(4,1)",128,0,0,0
	.stabs	"uint_least8_t:t(4,12)=(4,2)",128,0,0,0
	.stabs	"int_least16_t:t(4,13)=(4,3)",128,0,0,0
	.stabs	"uint_least16_t:t(4,14)=(4,4)",128,0,0,0
	.stabs	"int_least32_t:t(4,15)=(4,5)",128,0,0,0
	.stabs	"uint_least32_t:t(4,16)=(4,6)",128,0,0,0
	.stabs	"int_least64_t:t(4,17)=(4,7)",128,0,0,0
	.stabs	"uint_least64_t:t(4,18)=(4,8)",128,0,0,0
	.stabs	"int_fast8_t:t(4,19)=(4,1)",128,0,0,0
	.stabs	"uint_fast8_t:t(4,20)=(4,2)",128,0,0,0
	.stabs	"int_fast16_t:t(4,21)=(4,3)",128,0,0,0
	.stabs	"uint_fast16_t:t(4,22)=(4,4)",128,0,0,0
	.stabs	"int_fast32_t:t(4,23)=(4,5)",128,0,0,0
	.stabs	"uint_fast32_t:t(4,24)=(4,6)",128,0,0,0
	.stabs	"int_fast64_t:t(4,25)=(4,7)",128,0,0,0
	.stabs	"uint_fast64_t:t(4,26)=(4,8)",128,0,0,0
	.stabs	"intmax_t:t(4,27)=(4,7)",128,0,0,0
	.stabs	"uintmax_t:t(4,28)=(4,8)",128,0,0,0
	.stabn	162,0,0,0
	.stabs	"int_farptr_t:t(3,1)=(4,5)",128,0,0,0
	.stabs	"uint_farptr_t:t(3,2)=(4,6)",128,0,0,0
	.stabn	162,0,0,0
	.stabn	162,0,0,0
	.stabs	"/usr/bin/../lib/gcc/avr/4.1.2/../../../../avr/include/avr/fuse.h",130,0,0,0
	.stabs	"__fuse_t:t(5,1)=(5,2)=s2low:(0,11),0,8;high:(0,11),8,8;;",128,0,0,0
	.stabn	162,0,0,0
	.stabn	162,0,0,0
	.stabs	"main:F(0,1)",36,0,0,main
.global	main
	.type	main, @function
main:
	.stabn	68,0,7,.LM0-main
.LM0:
/* prologue: frame size=9 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,9
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	.stabn	68,0,9,.LM1-main
.LM1:
	ldi r24,lo8(243)
	ldi r25,hi8(243)
	ldi r26,hlo8(243)
	ldi r27,hhi8(243)
	std Y+6,r24
	std Y+7,r25
	std Y+8,r26
	std Y+9,r27
	.stabn	68,0,11,.LM2-main
.LM2:
	ldi r24,lo8(32)
	std Y+5,r24
	.stabn	68,0,13,.LM3-main
.LM3:
	ldi r24,lo8(100)
	ldi r25,hi8(100)
	std Y+4,r25
	std Y+3,r24
	.stabn	68,0,15,.LM4-main
.LM4:
	ldi r24,lo8(300)
	ldi r25,hi8(300)
	std Y+2,r25
	std Y+1,r24
	.stabn	68,0,16,.LM5-main
.LM5:
	call a
.L2:
	.stabn	68,0,17,.LM6-main
.LM6:
	rjmp .L2
/* epilogue: frame size=9 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 31 (21) */
	.size	main, .-main
	.stabs	"l:(4,6)",128,0,0,6
	.stabs	"k:(4,2)",128,0,0,5
	.stabs	"i:(4,4)",128,0,0,3
	.stabs	"j:(0,1)",128,0,0,1
	.stabn	192,0,0,main-main
	.stabn	224,0,0,.Lscope0-main
.Lscope0:
	.stabs	"a:F(0,15)",36,0,0,a
.global	a
	.type	a, @function
a:
	.stabn	68,0,20,.LM7-a
.LM7:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	.stabn	68,0,21,.LM8-a
.LM8:
	ldi r24,lo8(9)
	std Y+1,r24
	.stabn	68,0,22,.LM9-a
.LM9:
	call b
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function a size 23 (4) */
	.size	a, .-a
	.stabs	"i:(4,2)",128,0,0,1
	.stabn	192,0,0,a-a
	.stabn	224,0,0,.Lscope1-a
.Lscope1:
	.stabs	"b:F(0,15)",36,0,0,b
.global	b
	.type	b, @function
b:
	.stabn	68,0,25,.LM10-b
.LM10:
/* prologue: frame size=6 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	.stabn	68,0,26,.LM11-b
.LM11:
	ldi r24,lo8(10)
	ldi r25,hi8(10)
	std Y+6,r25
	std Y+5,r24
	.stabn	68,0,27,.LM12-b
.LM12:
	ldi r24,lo8(12)
	ldi r25,hi8(12)
	std Y+4,r25
	std Y+3,r24
	.stabn	68,0,28,.LM13-b
.LM13:
	ldd r24,Y+3
	ldd r25,Y+4
	ldd r18,Y+5
	ldd r19,Y+6
	movw r20,r24
	movw r22,r18
	ldi r24,lo8(1)
	call c
	std Y+2,r25
	std Y+1,r24
	.stabn	68,0,29,.LM14-b
.LM14:
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	std Y+2,r25
	std Y+1,r24
/* epilogue: frame size=6 */
	adiw r28,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function b size 43 (24) */
	.size	b, .-b
	.stabs	"i:(4,4)",128,0,0,5
	.stabs	"j:(0,1)",128,0,0,3
	.stabs	"k:(0,1)",128,0,0,1
	.stabn	192,0,0,b-b
	.stabn	224,0,0,.Lscope2-b
.Lscope2:
	.stabs	"c:F(0,1)",36,0,0,c
	.stabs	"a:p(0,2)",160,0,0,7
	.stabs	"b:p(4,4)",160,0,0,8
	.stabs	"c:p(0,1)",160,0,0,10
.global	c
	.type	c, @function
c:
	.stabn	68,0,32,.LM15-c
.LM15:
/* prologue: frame size=11 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,11
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+7,r24
	std Y+9,r23
	std Y+8,r22
	std Y+11,r21
	std Y+10,r20
	.stabn	68,0,34,.LM16-c
.LM16:
	ldd r24,Y+7
	mov r18,r24
	clr r19
	ldd r24,Y+10
	ldd r25,Y+11
	add r24,r18
	adc r25,r19
	std Y+6,r25
	std Y+5,r24
	.stabn	68,0,35,.LM17-c
.LM17:
	ldd r24,Y+7
	mov r18,r24
	clr r19
	ldd r24,Y+10
	ldd r25,Y+11
	sub r24,r18
	sbc r25,r19
	std Y+4,r25
	std Y+3,r24
	.stabn	68,0,36,.LM18-c
.LM18:
	ldd r18,Y+5
	ldd r19,Y+6
	ldd r24,Y+3
	ldd r25,Y+4
	add r24,r18
	adc r25,r19
	std Y+2,r25
	std Y+1,r24
	.stabn	68,0,37,.LM19-c
.LM19:
	ldd r24,Y+1
	ldd r25,Y+2
/* epilogue: frame size=11 */
	adiw r28,11
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function c size 52 (33) */
	.size	c, .-c
	.stabs	"x:(0,1)",128,0,0,5
	.stabs	"y:(0,1)",128,0,0,3
	.stabs	"z:(0,1)",128,0,0,1
	.stabn	192,0,0,c-c
	.stabn	224,0,0,.Lscope3-c
.Lscope3:
	.stabs	"",100,0,0,.Letext0
.Letext0:
/* File "../test1.c": code  149 = 0x0095 (  82), prologues  40, epilogues  27 */
