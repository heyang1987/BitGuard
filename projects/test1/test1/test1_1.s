/*	.file	"test1.c" */
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__  = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
	.text
.global	__vector_18
	.type	__vector_18, @function
__vector_18:
	push __zero_reg__
	push r0
	in r0,__SREG__
	push r0
	clr __zero_reg__
	push r24
	push r25
	push r26
	push r27
	push r29
	push r28
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: Signal */
/* frame size = 0 */
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
/* epilogue start */
	pop r28
	pop r29
	pop r27
	pop r26
	pop r25
	pop r24
	pop r0
	out __SREG__,r0
	pop r0
	pop __zero_reg__
	reti
	.size	__vector_18, .-__vector_18
.global	main
	.type	main, @function
main:
	push r29
	push r28
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,9
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue: function */
/* frame size = 9 */
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
/* #APP */
 ;  24 "test1.c" 1
	sei
 ;  0 "" 2
/* #NOAPP */
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
	ldi r24,lo8(300)
	ldi r25,hi8(300)
	std Y+2,r25
	std Y+1,r24
	ldd r18,Y+3
	ldd r19,Y+4
	ldd r20,Y+1
	ldd r21,Y+2
	ldi r24,lo8(1)
	movw r22,r18
	call foo
.L4:
	rjmp .L4
	.size	main, .-main
.global	foo
	.type	foo, @function
foo:
	push r29
	push r28
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
/* epilogue start */
	adiw r28,11
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r28
	pop r29
	ret
	.size	foo, .-foo
	.comm system_time,4,1
.global __do_clear_bss
