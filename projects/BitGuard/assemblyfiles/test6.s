	.file	"test6.c"
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__CCP__ = 0x34
__tmp_reg__ = 0
__zero_reg__ = 1
.global	callerstack1
	.section	.callerstack,"aw",@progbits
	.type	callerstack1, @object
	.size	callerstack1, 4
callerstack1:
	.byte	4
	.byte	0
	.byte	0
	.byte	0
.global	a
	.data
	.type	a, @object
	.size	a, 1
a:
	.byte	3
.global	b
	.type	b, @object
	.size	b, 2
b:
	.word	5
	.text
.global	main
	.type	main, @function
main:
	push r29
	push r28
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
.L__stack_usage = 2
.L2:
	rjmp .L2
	.size	main, .-main
.global __do_copy_data
