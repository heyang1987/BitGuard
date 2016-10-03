	.file	"test6.c"
	.arch atmega644p
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
.global	s
	.section	.snapshotSP,"aw",@progbits
	.type	s, @object
	.size	s, 2
s:
	.word	3
.global	t
	.type	t, @object
	.size	t, 2
t:
	.word	3
.global	bbb
	.section	.snapshot,"aw",@progbits
	.type	bbb, @object
	.size	bbb, 4
bbb:
	.byte	66
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
.LC0:
	.string	"0x%lx\n"
	.text
.global	main
	.type	main, @function
main:
/* prologue: frame size=0 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue end (size=4) */
	ldi r24,lo8(__snapshot_start)
	ldi r25,hi8(__snapshot_start)
	clr r26
	sbrc r25,7
	com r26
	mov r27,r26
	push r27
	push r26
	push r25
	push r24
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	push r25
	push r24
	call printf
	in r24,__SP_L__
	in r25,__SP_H__
	adiw r24,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r25
	out __SREG__,__tmp_reg__
	out __SP_L__,r24
.L2:
	rjmp .L2
/* epilogue: frame size=0 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 29 (25) */
	.size	main, .-main
/* File "test6.c": code   29 = 0x001d (  25), prologues   4, epilogues   0 */
