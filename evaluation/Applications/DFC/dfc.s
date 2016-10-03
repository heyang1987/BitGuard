	.file	"dfc.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	a
	.type	a, @function
a:
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 4 */
.L__stack_usage = 4
	ldi r24,lo8(9)
	ldi r25,0
	std Y+2,r25
	std Y+1,r24
	call b
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	ret
	.size	a, .-a
.global	b
	.type	b, @function
b:
	push r28
	push r29
	rcall .
	rcall .
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 6 */
/* stack size = 8 */
.L__stack_usage = 8
	ldi r24,lo8(10)
	ldi r25,0
	std Y+2,r25
	std Y+1,r24
	ldi r24,lo8(12)
	ldi r25,0
	std Y+4,r25
	std Y+3,r24
	ldd r18,Y+3
	ldd r19,Y+4
	ldd r24,Y+1
	ldd r25,Y+2
	movw r20,r18
	movw r22,r24
	ldi r24,lo8(1)
	ldi r25,0
	call c
	std Y+6,r25
	std Y+5,r24
	ldd r24,Y+5
	ldd r25,Y+6
	adiw r24,1
	std Y+6,r25
	std Y+5,r24
	ldd r24,Y+5
	ldd r25,Y+6
/* epilogue start */
	adiw r28,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
	.size	b, .-b
.global	c
	.type	c, @function
c:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,12
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 12 */
/* stack size = 14 */
.L__stack_usage = 14
	std Y+8,r25
	std Y+7,r24
	std Y+10,r23
	std Y+9,r22
	std Y+12,r21
	std Y+11,r20
	ldd r18,Y+7
	ldd r19,Y+8
	ldd r24,Y+11
	ldd r25,Y+12
	add r24,r18
	adc r25,r19
	std Y+2,r25
	std Y+1,r24
	ldd r18,Y+11
	ldd r19,Y+12
	ldd r24,Y+7
	ldd r25,Y+8
	movw r20,r18
	sub r20,r24
	sbc r21,r25
	movw r24,r20
	std Y+4,r25
	std Y+3,r24
	ldd r18,Y+1
	ldd r19,Y+2
	ldd r24,Y+3
	ldd r25,Y+4
	add r24,r18
	adc r25,r19
	std Y+6,r25
	std Y+5,r24
	ldd r24,Y+5
	ldd r25,Y+6
/* epilogue start */
	adiw r28,12
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
	.size	c, .-c
.global	main
	.type	main, @function
main:
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
/* prologue: function */
/* frame size = 11 */
/* stack size = 13 */
.L__stack_usage = 13
	ldi r24,lo8(69)
	ldi r25,0
	ldi r18,lo8(69)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(5)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(-124)
	ldi r25,0
	movw r30,r24
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	ldi r24,lo8(-13)
	ldi r25,0
	ldi r26,0
	ldi r27,0
	std Y+1,r24
	std Y+2,r25
	std Y+3,r26
	std Y+4,r27
	ldi r24,lo8(32)
	std Y+5,r24
	ldi r24,lo8(100)
	ldi r25,0
	std Y+7,r25
	std Y+6,r24
	ldi r24,lo8(44)
	ldi r25,lo8(1)
	std Y+9,r25
	std Y+8,r24
.L8:
	call a
	std Y+11,r25
	std Y+10,r24
	ldd r24,Y+10
	ldd r25,Y+11
	adiw r24,1
	std Y+11,r25
	std Y+10,r24
	rjmp .L8
	.size	main, .-main
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_3.4.2_992) 4.7.2"
