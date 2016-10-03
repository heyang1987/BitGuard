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
	.data
	.type	pre, @object
	.size	pre, 2
pre:
	.word	300
.global	counter
.global	counter
	.section .bss
	.type	counter, @object
	.size	counter, 2
counter:
	.skip 2,0
.global	num
.global	num
	.type	num, @object
	.size	num, 4
num:
	.skip 4,0
	.data
.LC0:
	.string	"\n"
	.text
.global	__vector_18
	.type	__vector_18, @function
__vector_18:
/* prologue: frame size=8 */
	push __zero_reg__
	push __tmp_reg__
	in __tmp_reg__,__SREG__
	push __tmp_reg__
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,8
	out __SP_H__,r29
	out __SP_L__,r28
/* prologue end (size=24) */
	lds r18,counter
	lds r19,(counter)+1
	lds r24,pre
	lds r25,(pre)+1
	cp r18,r24
	cpc r19,r25
	brlo .L2
	lds r24,num
	lds r25,(num)+1
	lds r26,(num)+2
	lds r27,(num)+3
	movw r18,r24
	ldi r20,lo8(10)
	ldi r21,hi8(10)
	movw r24,r28
	adiw r24,1
	movw r22,r24
	movw r24,r18
	call itoa
	movw r24,r28
	adiw r24,1
	call uart_send_string
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call uart_send_string
	lds r24,num
	lds r25,(num)+1
	lds r26,(num)+2
	lds r27,(num)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts num,r24
	sts (num)+1,r25
	sts (num)+2,r26
	sts (num)+3,r27
	sts (counter)+1,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L5
.L2:
	lds r24,counter
	lds r25,(counter)+1
	adiw r24,1
	sts (counter)+1,r25
	sts counter,r24
.L5:
/* epilogue: frame size=8 */
	adiw r28,8
	cli
	out __SP_H__,r29
	out __SP_L__,r28
	pop r29
	pop r28
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop __tmp_reg__
	out __SREG__,__tmp_reg__
	pop __tmp_reg__
	pop __zero_reg__
	reti
/* epilogue end (size=23) */
/* function __vector_18 size 116 (69) */
	.size	__vector_18, .-__vector_18
	.data
	.type	C.5.1474, @object
	.size	C.5.1474, 8
C.5.1474:
	.byte	0
	.byte	-62
	.byte	1
	.byte	0
	.word	0
	.byte	8
	.byte	1
.LC1:
	.string	"UART Ready.\n"
	.text
.global	main
	.type	main, @function
main:
/* prologue: frame size=26 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,26
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	movw r24,r28
	adiw r24,1
	std Y+18,r25
	std Y+17,r24
	ldi r30,lo8(C.5.1474)
	ldi r31,hi8(C.5.1474)
	std Y+20,r31
	std Y+19,r30
	ldi r31,lo8(8)
	std Y+21,r31
.L7:
	ldd r30,Y+19
	ldd r31,Y+20
	ld r0,Z
	ldd r24,Y+19
	ldd r25,Y+20
	adiw r24,1
	std Y+20,r25
	std Y+19,r24
	ldd r30,Y+17
	ldd r31,Y+18
	st Z,r0
	ldd r24,Y+17
	ldd r25,Y+18
	adiw r24,1
	std Y+18,r25
	std Y+17,r24
	ldd r25,Y+21
	subi r25,lo8(-(-1))
	std Y+21,r25
	ldd r30,Y+21
	tst r30
	brne .L7
	movw r24,r28
	adiw r24,9
	std Y+23,r25
	std Y+22,r24
	movw r30,r28
	adiw r30,1
	std Y+25,r31
	std Y+24,r30
	ldi r31,lo8(8)
	std Y+26,r31
.L8:
	ldd r30,Y+24
	ldd r31,Y+25
	ld r0,Z
	ldd r24,Y+24
	ldd r25,Y+25
	adiw r24,1
	std Y+25,r25
	std Y+24,r24
	ldd r30,Y+22
	ldd r31,Y+23
	st Z,r0
	ldd r24,Y+22
	ldd r25,Y+23
	adiw r24,1
	std Y+23,r25
	std Y+22,r24
	ldd r25,Y+26
	subi r25,lo8(-(-1))
	std Y+26,r25
	ldd r30,Y+26
	tst r30
	brne .L8
	movw r24,r28
	adiw r24,9
	call uart_init
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call uart_send_string
	ldi r26,lo8(110)
	ldi r27,hi8(110)
	ldi r30,lo8(110)
	ldi r31,hi8(110)
	ld r24,Z
	ori r24,lo8(1)
	st X,r24
	ldi r30,lo8(132)
	ldi r31,hi8(132)
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	ldi r26,lo8(69)
	ldi r27,hi8(69)
	ldi r30,lo8(69)
	ldi r31,hi8(69)
	ld r24,Z
	ori r24,lo8(4)
	st X,r24
/* #APP */
	sei
/* #NOAPP */
.L9:
	rjmp .L9
/* epilogue: frame size=26 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 103 (93) */
	.size	main, .-main
/* File "sendNum.c": code  219 = 0x00db ( 162), prologues  34, epilogues  23 */
