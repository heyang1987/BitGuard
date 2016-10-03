	.file	$"test1.c"
__SREG__:	=	$0x3f
__SP_H__:	=	$0x3e
__SP_L__:	=	$0x3d
__CCP__:	=	$0x34
__tmp_reg__:	=	$0
__zero_reg__:	=	$1
	.text	
.global:	__vector_18	
	.type	$@function,$__vector_18
__vector_18:		
	push	$__zero_reg__
	push	$r0
	in	$__SREG__,$r0
	push	$r0
	clr	$__zero_reg__
	push	$r24
	push	$r25
	push	$r26
	push	$r27
	push	$r29
	push	$r28
	in	$__SP_L__,$r28
	in	$__SP_H__,$r29
/*:	prologue:	$Signal */
/*:	frame	$size = 0 */
	lds	$system_time,$r24
	lds	$(system_time)+1,$r25
	lds	$(system_time)+2,$r26
	lds	$(system_time)+3,$r27
	adiw	$1,$r24
	adc	$__zero_reg__,$r26
	adc	$__zero_reg__,$r27
	sts	$r24,$system_time
	sts	$r25,$(system_time)+1
	sts	$r26,$(system_time)+2
	sts	$r27,$(system_time)+3
/*:	epilogue	$start */
	pop	$r28
	pop	$r29
	pop	$r27
	pop	$r26
	pop	$r25
	pop	$r24
	pop	$r0
	out	$r0,$__SREG__
	pop	$r0
	pop	$__zero_reg__
	reti	
	.size	$.-__vector_18,$__vector_18
.global:	main	
	.type	$@function,$main
main:		
	push	$r29
	push	$r28
	in	$__SP_L__,$r28
	in	$__SP_H__,$r29
	sbiw	$9,$r28
	in	$__SREG__,$__tmp_reg__
	cli	
	out	$r29,$__SP_H__
	out	$__tmp_reg__,$__SREG__
	out	$r28,$__SP_L__
/*:	prologue:	$function */
/*:	frame	$size = 9 */
	sts	$__zero_reg__,$system_time
	sts	$__zero_reg__,$(system_time)+1
	sts	$__zero_reg__,$(system_time)+2
	sts	$__zero_reg__,$(system_time)+3
	ldi	$lo8(110),$r26
	ldi	$hi8(110),$r27
	ldi	$lo8(110),$r30
	ldi	$hi8(110),$r31
	ld	$Z,$r24
	ori	$lo8(1),$r24
	st	$r24,$X
	ldi	$lo8(69),$r26
	ldi	$hi8(69),$r27
	ldi	$lo8(69),$r30
	ldi	$hi8(69),$r31
	ld	$Z,$r24
	ori	$lo8(1),$r24
	st	$r24,$X
/*:	#APP	$*/
#  24 "test1.c" 1
	sei	
#  0 "" 2
/*:	#NOAPP	$*/
	ldi	$lo8(243),$r24
	ldi	$hi8(243),$r25
	ldi	$hlo8(243),$r26
	ldi	$hhi8(243),$r27
	std	$r24,$Y+6
	std	$r25,$Y+7
	std	$r26,$Y+8
	std	$r27,$Y+9
	ldi	$lo8(32),$r24
	std	$r24,$Y+5
	ldi	$lo8(100),$r24
	ldi	$hi8(100),$r25
	std	$r25,$Y+4
	std	$r24,$Y+3
	ldi	$lo8(300),$r24
	ldi	$hi8(300),$r25
	std	$r25,$Y+2
	std	$r24,$Y+1
	ldd	$Y+3,$r18
	ldd	$Y+4,$r19
	ldd	$Y+1,$r20
	ldd	$Y+2,$r21
	ldi	$lo8(1),$r24
	movw	$r18,$r22
	call	$foo
.L4:		
	rjmp	$.L4
	.size	$.-main,$main
.global:	foo	
	.type	$@function,$foo
foo:		
	push	$r29
	push	$r28
	in	$__SP_L__,$r28
	in	$__SP_H__,$r29
	sbiw	$11,$r28
	in	$__SREG__,$__tmp_reg__
	cli	
	out	$r29,$__SP_H__
	out	$__tmp_reg__,$__SREG__
	out	$r28,$__SP_L__
/*:	prologue:	$function */
/*:	frame	$size = 11 */
	std	$r24,$Y+7
	std	$r23,$Y+9
	std	$r22,$Y+8
	std	$r21,$Y+11
	std	$r20,$Y+10
	ldd	$Y+7,$r24
	mov	$r24,$r18
	clr	$r19
	sbrc	$7,$r18
	com	$r19
	ldd	$Y+10,$r24
	ldd	$Y+11,$r25
	add	$r18,$r24
	adc	$r19,$r25
	std	$r25,$Y+6
	std	$r24,$Y+5
	ldd	$Y+7,$r24
	mov	$r24,$r18
	clr	$r19
	sbrc	$7,$r18
	com	$r19
	ldd	$Y+10,$r24
	ldd	$Y+11,$r25
	sub	$r18,$r24
	sbc	$r19,$r25
	std	$r25,$Y+4
	std	$r24,$Y+3
	ldd	$Y+5,$r18
	ldd	$Y+6,$r19
	ldd	$Y+3,$r24
	ldd	$Y+4,$r25
	add	$r18,$r24
	adc	$r19,$r25
	std	$r25,$Y+2
	std	$r24,$Y+1
	ldd	$Y+1,$r24
	ldd	$Y+2,$r25
/*:	epilogue	$start */
	adiw	$11,$r28
	in	$__SREG__,$__tmp_reg__
	cli	
	out	$r29,$__SP_H__
	out	$__tmp_reg__,$__SREG__
	out	$r28,$__SP_L__
	pop	$r28
	pop	$r29
	ret	
	.size	$.-foo,$foo
	.comm	$1,$4,$system_time
.global:	__do_clear_bss	
