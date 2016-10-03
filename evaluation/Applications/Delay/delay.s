	.file	"delay.c"
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
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,13
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 13 */
/* stack size = 15 */
.L__stack_usage = 15
	ldi r24,lo8(1)
	ldi r25,0
	std Y+3,r25
	std Y+2,r24
	ldi r24,lo8(2)
	ldi r25,0
	std Y+5,r25
	std Y+4,r24
	ldd r18,Y+2
	ldd r19,Y+3
	ldd r24,Y+4
	ldd r25,Y+5
	add r24,r18
	adc r25,r19
	std Y+7,r25
	std Y+6,r24
	ldd r18,Y+2
	ldd r19,Y+3
	ldd r24,Y+4
	ldd r25,Y+5
	add r18,r24
	adc r19,r25
	ldd r24,Y+6
	ldd r25,Y+7
	add r24,r18
	adc r25,r19
	std Y+9,r25
	std Y+8,r24
	ldd r18,Y+2
	ldd r19,Y+3
	ldd r24,Y+4
	ldd r25,Y+5
	add r18,r24
	adc r19,r25
	ldd r24,Y+6
	ldd r25,Y+7
	add r18,r24
	adc r19,r25
	ldd r24,Y+8
	ldd r25,Y+9
	add r24,r18
	adc r25,r19
	std Y+11,r25
	std Y+10,r24
	ldd r18,Y+2
	ldd r19,Y+3
	ldd r24,Y+4
	ldd r25,Y+5
	add r18,r24
	adc r19,r25
	ldd r24,Y+6
	ldd r25,Y+7
	add r18,r24
	adc r19,r25
	ldd r24,Y+8
	ldd r25,Y+9
	add r18,r24
	adc r19,r25
	ldd r24,Y+10
	ldd r25,Y+11
	add r24,r18
	adc r25,r19
	std Y+13,r25
	std Y+12,r24
	ldi r24,lo8(100)
	std Y+1,r24
	rjmp .L2
.L3:
	ldd r24,Y+1
	subi r24,lo8(-(-1))
	std Y+1,r24
.L2:
	ldd r24,Y+1
	tst r24
	brne .L3
	ldd r24,Y+12
	ldd r25,Y+13
/* epilogue start */
	adiw r28,13
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
	.size	a, .-a
.global	main
	.type	main, @function
main:
	push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 1 */
/* stack size = 3 */
.L__stack_usage = 3
	ldi r24,lo8(69)
	ldi r25,0
	ldi r18,lo8(69)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(1)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(69)
	ldi r25,0
	ldi r18,lo8(69)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(4)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(110)
	ldi r25,0
	ldi r18,lo8(110)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(1)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(-124)
	ldi r25,0
	movw r30,r24
	std Z+1,__zero_reg__
	st Z,__zero_reg__
.L8:
	call a
	ldi r24,lo8(100)
	std Y+1,r24
	rjmp .L6
.L7:
	ldd r24,Y+1
	subi r24,lo8(-(-1))
	std Y+1,r24
.L6:
	ldd r24,Y+1
	tst r24
	brne .L7
	rjmp .L8
	.size	main, .-main
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_3.4.2_992) 4.7.2"
