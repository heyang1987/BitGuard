	.file	"test4.c"
	.arch atmega644
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
	.text
.global	__vector_18
	.type	__vector_18, @function
__vector_18:
/* prologue: frame size=0 */
	push __zero_reg__
	push __tmp_reg__
	in __tmp_reg__,__SREG__
	push __tmp_reg__
	clr __zero_reg__
	push r24
	push r25
	push r26
	push r27
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue end (size=13) */
	lds r24,system_time
	lds r25,(system_time)+1
	lds r26,(system_time)+2
	lds r27,(system_time)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts system_time,r24
	sts (system_time)+1,r25
	sts (system_time)+2,r26
	sts (system_time)+3,r27
/* epilogue: frame size=0 */
	pop r29
	pop r28
	pop r27
	pop r26
	pop r25
	pop r24
	pop __tmp_reg__
	out __SREG__,__tmp_reg__
	pop __tmp_reg__
	pop __zero_reg__
	reti
/* epilogue end (size=11) */
/* function __vector_18 size 43 (19) */
	.size	__vector_18, .-__vector_18
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
/* prologue: frame size=3 */
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
	sbiw r28,3
	out __SP_H__,r29
	out __SP_L__,r28
/* prologue end (size=24) */
	ldi r24,lo8(1)
	ldi r25,hi8(1)
	std Y+3,r25
	std Y+2,r24
	ldi r24,lo8(2)
	std Y+1,r24
	ldd r24,Y+2
	ldd r25,Y+3
	movw r20,r24
	ldi r22,lo8(10)
	ldi r23,hi8(10)
	ldd r24,Y+1
	call c
/* epilogue: frame size=3 */
	adiw r28,3
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
/* function __vector_1 size 61 (14) */
	.size	__vector_1, .-__vector_1
.global	main
	.type	main, @function
main:
/* prologue: frame size=4 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,4
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	sts system_time,__zero_reg__
	sts (system_time)+1,__zero_reg__
	sts (system_time)+2,__zero_reg__
	sts (system_time)+3,__zero_reg__
	ldi r26,lo8(110)
	ldi r27,hi8(110)
	ldi r30,lo8(110)
	ldi r31,hi8(110)
	ld r24,Z
	ori r24,lo8(1)
	st X,r24
	ldi r26,lo8(69)
	ldi r27,hi8(69)
	ldi r30,lo8(69)
	ldi r31,hi8(69)
	ld r24,Z
	ori r24,lo8(1)
	st X,r24
	ldi r26,lo8(42)
	ldi r27,hi8(42)
	ldi r30,lo8(42)
	ldi r31,hi8(42)
	ld r24,Z
	andi r24,lo8(-5)
	st X,r24
	ldi r26,lo8(43)
	ldi r27,hi8(43)
	ldi r30,lo8(43)
	ldi r31,hi8(43)
	ld r24,Z
	ori r24,lo8(4)
	st X,r24
	ldi r26,lo8(61)
	ldi r27,hi8(61)
	ldi r30,lo8(61)
	ldi r31,hi8(61)
	ld r24,Z
	ori r24,lo8(1)
	st X,r24
	ldi r30,lo8(105)
	ldi r31,hi8(105)
	st Z,__zero_reg__
/* #APP */
	sei
/* #NOAPP */
	ldi r24,lo8(100)
	ldi r25,hi8(100)
	std Y+4,r25
	std Y+3,r24
	ldi r24,lo8(300)
	ldi r25,hi8(300)
	std Y+2,r25
	std Y+1,r24
	call a
.L6:
	rjmp .L6
/* epilogue: frame size=4 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 69 (59) */
	.size	main, .-main
.global	a
	.type	a, @function
a:
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
	ldi r24,lo8(9)
	std Y+1,r24
	ldd r24,Y+1
	subi r24,lo8(-(1))
	std Y+1,r24
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
/* function a size 24 (5) */
	.size	a, .-a
.global	c
	.type	c, @function
c:
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
	ldd r24,Y+7
	mov r18,r24
	clr r19
	sbrc r18,7
	com r19
	ldd r24,Y+10
	ldd r25,Y+11
	add r24,r18
	adc r25,r19
	std Y+6,r25
	std Y+5,r24
	ldd r24,Y+7
	mov r18,r24
	clr r19
	sbrc r18,7
	com r19
	ldd r24,Y+10
	ldd r25,Y+11
	sub r24,r18
	sbc r25,r19
	std Y+4,r25
	std Y+3,r24
	ldd r18,Y+5
	ldd r19,Y+6
	ldd r24,Y+3
	ldd r25,Y+4
	add r24,r18
	adc r25,r19
	std Y+2,r25
	std Y+1,r24
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
/* function c size 56 (37) */
	.size	c, .-c
	.comm system_time,4,1
/* File "test4.c": code  253 = 0x00fd ( 134), prologues  67, epilogues  52 */
