	.file	"test5.c"
	.arch atmega644
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
	.text
.global	main
	.type	main, @function
main:
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
	ldi r24,lo8(243)
	ldi r25,hi8(243)
	ldi r26,hlo8(243)
	ldi r27,hhi8(243)
	std Y+6,r24
	std Y+7,r25
	std Y+8,r26
	std Y+9,r27
	ldi r24,lo8(32)
	std Y+5,r24
	ldi r24,lo8(100)
	ldi r25,hi8(100)
	std Y+4,r25
	std Y+3,r24
	ldi r24,lo8(5)
	ldi r25,hi8(5)
	call a
	std Y+2,r25
	std Y+1,r24
.L2:
	rjmp .L2
/* epilogue: frame size=9 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 31 (21) */
	.size	main, .-main
.global	a
	.type	a, @function
a:
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
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	cp __zero_reg__,r24
	cpc __zero_reg__,r25
	brge .L5
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,1
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	call a
	movw r18,r24
	ldd r24,Y+1
	ldd r25,Y+2
	movw r20,r18
	add r20,r24
	adc r21,r25
	std Y+4,r21
	std Y+3,r20
	rjmp .L7
.L5:
	ldd r24,Y+1
	ldd r25,Y+2
	std Y+4,r25
	std Y+3,r24
.L7:
	ldd r24,Y+3
	ldd r25,Y+4
/* epilogue: frame size=4 */
	adiw r28,4
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function a size 50 (31) */
	.size	a, .-a
/* File "test5.c": code   81 = 0x0051 (  52), prologues  20, epilogues   9 */
