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
/* prologue end (size=9) */
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
	pop r27
	pop r26
	pop r25
	pop r24
	pop __tmp_reg__
	out __SREG__,__tmp_reg__
	pop __tmp_reg__
	pop __zero_reg__
	reti
/* epilogue end (size=9) */
/* function __vector_18 size 37 (19) */
	.size	__vector_18, .-__vector_18
.global	a
	.type	a, @function
a:
/* prologue: frame size=0 */
/* prologue end (size=0) */
/* epilogue: frame size=0 */
	ret
/* epilogue end (size=1) */
/* function a size 1 (0) */
	.size	a, .-a
.global	main
	.type	main, @function
main:
/* prologue: frame size=0 */
/* prologue end (size=0) */
	sts system_time,__zero_reg__
	sts (system_time)+1,__zero_reg__
	sts (system_time)+2,__zero_reg__
	sts (system_time)+3,__zero_reg__
	lds r24,110
	ori r24,lo8(1)
	sts 110,r24
	in r24,69-0x20
	ori r24,lo8(1)
	out 69-0x20,r24
	cbi 42-0x20,2
	sbi 43-0x20,2
	sbi 61-0x20,0
	sts 105,__zero_reg__
/* #APP */
	sei
/* #NOAPP */
.L6:
	rjmp .L6
/* epilogue: frame size=0 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 24 (24) */
	.size	main, .-main
.global	c
	.type	c, @function
c:
/* prologue: frame size=0 */
/* prologue end (size=0) */
	movw r24,r20
	lsl r24
	rol r25
/* epilogue: frame size=0 */
	ret
/* epilogue end (size=1) */
/* function c size 4 (3) */
	.size	c, .-c
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
/* prologue: frame size=0 */
	push __zero_reg__
	push __tmp_reg__
	in __tmp_reg__,__SREG__
	push __tmp_reg__
	clr __zero_reg__
/* prologue end (size=5) */
/* epilogue: frame size=0 */
	pop __tmp_reg__
	out __SREG__,__tmp_reg__
	pop __tmp_reg__
	pop __zero_reg__
	reti
/* epilogue end (size=5) */
/* function __vector_1 size 10 (0) */
	.size	__vector_1, .-__vector_1
	.comm system_time,4,1
/* File "test4.c": code   76 = 0x004c (  46), prologues  14, epilogues  16 */
