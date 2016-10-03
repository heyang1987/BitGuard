	.file	"testISR.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	__vector_18
	.type	__vector_18, @function
__vector_18:
	push r1
	push r0
	lds r0,95
	push r0
	clr __zero_reg__
	push r24
	push r28
	push r29
	push __zero_reg__
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: Signal */
/* frame size = 1 */
/* stack size = 7 */
.L__stack_usage = 7
	ldd r24,Y+1
	subi r24,lo8(-(1))
	std Y+1,r24
/* epilogue start */
	pop __tmp_reg__
	pop r29
	pop r28
	pop r24
	pop r0
	sts 95,r0
	pop r0
	pop r1
	reti
	.size	__vector_18, .-__vector_18
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r24,lo8(69)
	ldi r25,0
	ldi r18,lo8(69)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(1)
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
/* #APP */
 ;  22 "testISR.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
.L3:
	call a
	rjmp .L3
	.size	main, .-main
.global	a
	.type	a, @function
a:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
	ldi r24,lo8(93)
	ldi r25,0
	movw r30,r24
	ld r24,Z
	ldd r25,Z+1
/* epilogue start */
	pop r29
	pop r28
	ret
	.size	a, .-a
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_3.4.2_992) 4.7.2"
