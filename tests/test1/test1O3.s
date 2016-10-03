	.file	"test1.c"
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
	ldi r24,lo8(25)
	ldi r25,hi8(25)
/* epilogue: frame size=0 */
	ret
/* epilogue end (size=1) */
/* function a size 3 (2) */
	.size	a, .-a
.global	b
	.type	b, @function
b:
/* prologue: frame size=0 */
/* prologue end (size=0) */
	ldi r24,lo8(25)
	ldi r25,hi8(25)
/* epilogue: frame size=0 */
	ret
/* epilogue end (size=1) */
/* function b size 3 (2) */
	.size	b, .-b
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
.global	main
	.type	main, @function
main:
/* prologue: frame size=0 */
/* prologue end (size=0) */
.L8:
	rjmp .L8
/* epilogue: frame size=0 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 1 (1) */
	.size	main, .-main
/* File "test1.c": code   11 = 0x000b (   8), prologues   0, epilogues   3 */
