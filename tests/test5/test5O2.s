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
.global	a
	.type	a, @function
a:
/* prologue: frame size=0 */
/* prologue end (size=0) */
	cp __zero_reg__,r24
	cpc __zero_reg__,r25
	brge .L10
	ldi r18,lo8(0)
	ldi r19,hi8(0)
.L6:
	sbiw r24,1
	add r18,r24
	adc r19,r25
	sbiw r24,0
	brne .L6
	rjmp .L5
.L10:
	ldi r18,lo8(0)
	ldi r19,hi8(0)
.L5:
	add r24,r18
	adc r25,r19
/* epilogue: frame size=0 */
	ret
/* epilogue end (size=1) */
/* function a size 16 (15) */
	.size	a, .-a
.global	main
	.type	main, @function
main:
/* prologue: frame size=0 */
/* prologue end (size=0) */
.L12:
	rjmp .L12
/* epilogue: frame size=0 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 1 (1) */
	.size	main, .-main
/* File "test5.c": code   17 = 0x0011 (  16), prologues   0, epilogues   1 */
