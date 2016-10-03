	.file	"test2.c"
	.arch atmega644
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
	.text
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
.global	b
	.type	b, @function
b:
/* prologue: frame size=0 */
/* prologue end (size=0) */
/* epilogue: frame size=0 */
	ret
/* epilogue end (size=1) */
/* function b size 1 (0) */
	.size	b, .-b
.global	a
	.type	a, @function
a:
/* prologue: frame size=0 */
/* prologue end (size=0) */
/* epilogue: frame size=0 */
	ret
/* epilogue end (size=1) */
/* function a size 1 (0) */
	.size	a, .-a
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
/* File "test2.c": code    7 = 0x0007 (   4), prologues   0, epilogues   3 */
