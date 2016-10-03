	.file	"testCRC.c"
	.arch atmega644p
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
	ldi r24,lo8(243)
	ldi r25,hi8(243)
	ldi r26,hlo8(243)
	ldi r27,hhi8(243)
	std Y+8,r24
	std Y+9,r25
	std Y+10,r26
	std Y+11,r27
	ldi r24,lo8(32)
	std Y+7,r24
	ldi r24,lo8(100)
	ldi r25,hi8(100)
	std Y+6,r25
	std Y+5,r24
	ldi r24,lo8(300)
	ldi r25,hi8(300)
	std Y+4,r25
	std Y+3,r24
	ldd r20,Y+5
	ldd r21,Y+6
	ldd r24,Y+7
	clr r25
	ldd r18,Y+8
	ldd r19,Y+9
	movw r22,r24
	movw r24,r18
	call a
	std Y+2,r25
	std Y+1,r24
.L2:
	rjmp .L2
/* epilogue: frame size=11 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 41 (31) */
	.size	main, .-main
.global	a
	.type	a, @function
a:
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
	std Y+2,r25
	std Y+1,r24
	std Y+4,r23
	std Y+3,r22
	std Y+6,r21
	std Y+5,r20
	ldd r18,Y+1
	ldd r19,Y+2
	ldd r24,Y+3
	ldd r25,Y+4
	add r18,r24
	adc r19,r25
	ldd r24,Y+5
	ldd r25,Y+6
	add r24,r18
	adc r25,r19
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
/* function a size 35 (16) */
	.size	a, .-a
/* File "testCRC.c": code   76 = 0x004c (  47), prologues  20, epilogues   9 */
