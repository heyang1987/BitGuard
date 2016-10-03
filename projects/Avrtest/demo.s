	/*.file	"demo.c"*/
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
	ldi r24,lo8(1)
	ldi r25,hi8(1)
	std Y+4,r25
	std Y+3,r24
	ldi r24,lo8(300)
	ldi r25,hi8(300)
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	ldd r18,Y+3
	ldd r19,Y+4
	movw r20,r24
	movw r22,r18
	ldi r24,lo8(1)
	call foo
	ldi r24,lo8(0)
	ldi r25,hi8(0)
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
/* function main size 38 (19) */
	.size	main, .-main
.global	foo
	.type	foo, @function
foo:
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
	ldd r24,Y+8
	ldd r25,Y+9
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
/* function foo size 56 (37) */
	.size	foo, .-foo
/* File "demo.c": code   94 = 0x005e (  56), prologues  20, epilogues  18 */
