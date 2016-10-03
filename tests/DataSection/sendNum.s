	.file	"sendNum.c"
	.arch atmega644p
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
.global	pre
	.section	.data.pre,"aw",@progbits
	.type	pre, @object
	.size	pre, 2
pre:
	.word	300
.global	counter
	.section	.bss.counter,"aw",@nobits
	.type	counter, @object
	.size	counter, 2
counter:
	.skip 2,0
.global	num
	.section	.bss.num,"aw",@nobits
	.type	num, @object
	.size	num, 4
num:
	.skip 4,0
.global	pp1
	.section	.data.pp1,"aw",@progbits
	.type	pp1, @object
	.size	pp1, 40
pp1:
	.string	"Your program has died a horrible death!"
	.section	.rodata.C.0.1459,"a",@progbits
	.type	C.0.1459, @object
	.size	C.0.1459, 7
C.0.1459:
	.byte	0
	.byte	-62
	.byte	1
	.byte	0
	.byte	0
	.byte	8
	.byte	1
	.data
.LC0:
	.string	"UART Ready.\n"
	.section	.text.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: frame size=24 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,24
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	movw r24,r28
	adiw r24,1
	std Y+16,r25
	std Y+15,r24
	ldi r30,lo8(C.0.1459)
	ldi r31,hi8(C.0.1459)
	std Y+18,r31
	std Y+17,r30
	ldi r31,lo8(7)
	std Y+19,r31
.L2:
	ldd r30,Y+17
	ldd r31,Y+18
	ld r0,Z
	ldd r24,Y+17
	ldd r25,Y+18
	adiw r24,1
	std Y+18,r25
	std Y+17,r24
	ldd r30,Y+15
	ldd r31,Y+16
	st Z,r0
	ldd r24,Y+15
	ldd r25,Y+16
	adiw r24,1
	std Y+16,r25
	std Y+15,r24
	ldd r25,Y+19
	subi r25,lo8(-(-1))
	std Y+19,r25
	ldd r30,Y+19
	tst r30
	brne .L2
	movw r24,r28
	adiw r24,8
	std Y+21,r25
	std Y+20,r24
	movw r30,r28
	adiw r30,1
	std Y+23,r31
	std Y+22,r30
	ldi r31,lo8(7)
	std Y+24,r31
.L3:
	ldd r30,Y+22
	ldd r31,Y+23
	ld r0,Z
	ldd r24,Y+22
	ldd r25,Y+23
	adiw r24,1
	std Y+23,r25
	std Y+22,r24
	ldd r30,Y+20
	ldd r31,Y+21
	st Z,r0
	ldd r24,Y+20
	ldd r25,Y+21
	adiw r24,1
	std Y+21,r25
	std Y+20,r24
	ldd r25,Y+24
	subi r25,lo8(-(-1))
	std Y+24,r25
	ldd r30,Y+24
	tst r30
	brne .L3
	movw r24,r28
	adiw r24,8
	call uart_init
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call uart_send_string
.L4:
	ldi r24,lo8(pp1)
	ldi r25,hi8(pp1)
	ldi r18,lo8(pp2)
	ldi r19,hi8(pp2)
	movw r22,r24
	movw r24,r18
	call strcpy
	rjmp .L4
/* epilogue: frame size=24 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 91 (81) */
	.size	main, .-main
	.comm pp2,1,1
/* File "sendNum.c": code   91 = 0x005b (  81), prologues  10, epilogues   0 */
