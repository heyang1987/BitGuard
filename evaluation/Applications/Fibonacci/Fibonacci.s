	.file	"Fibonacci.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
.global	counter
	.section .bss
	.type	counter, @object
	.size	counter, 4
counter:
	.zero	4
.global	i
	.type	i, @object
	.size	i, 4
i:
	.zero	4
	.comm	size,2,1
	.comm	addr,2,1
	.comm	p,2,1
	.text
.global	fibonacci_recursive
	.type	fibonacci_recursive, @function
fibonacci_recursive:
	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 6 */
.L__stack_usage = 6
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,0
	brne .L2
	ldi r24,0
	ldi r25,0
	rjmp .L3
.L2:
	ldd r24,Y+1
	ldd r25,Y+2
	cpi r24,1
	cpc r25,__zero_reg__
	brne .L4
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L3
.L4:
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,1
	call fibonacci_recursive
	movw r16,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,2
	call fibonacci_recursive
	add r24,r16
	adc r25,r17
.L3:
/* epilogue start */
	pop __tmp_reg__
	pop __tmp_reg__
	pop r29
	pop r28
	pop r17
	pop r16
	ret
	.size	fibonacci_recursive, .-fibonacci_recursive
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
.L6:
	ldi r24,lo8(10)
	ldi r25,0
	call fibonacci_recursive
	rjmp .L6
	.size	main, .-main
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_3.4.2_992) 4.7.2"
.global __do_clear_bss
