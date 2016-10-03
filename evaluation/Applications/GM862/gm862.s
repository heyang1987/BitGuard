	.file	"gm862.c"
	.arch atmega644p
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
	.text
.global	gm862_init
	.type	gm862_init, @function
gm862_init:
/* prologue: frame size=2 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,2
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	call uart_init
	ldi r30,lo8(33)
	ldi r31,hi8(33)
	ldi r24,lo8(64)
	st Z,r24
	ldi r30,lo8(39)
	ldi r31,hi8(39)
	ldi r24,lo8(16)
	st Z,r24
	ldi r26,lo8(34)
	ldi r27,hi8(34)
	ldi r30,lo8(34)
	ldi r31,hi8(34)
	ld r24,Z
	andi r24,lo8(-65)
	st X,r24
	ldi r26,lo8(40)
	ldi r27,hi8(40)
	ldi r30,lo8(40)
	ldi r31,hi8(40)
	ld r24,Z
	andi r24,lo8(-17)
	st X,r24
/* epilogue: frame size=2 */
	adiw r28,2
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_init size 47 (28) */
	.size	gm862_init, .-gm862_init
	.data
.LC0:
	.string	"AT\r"
.LC1:
	.string	"\r\nOK\r\n"
	.text
.global	gm862_wake
	.type	gm862_wake, @function
gm862_wake:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	ldi r26,lo8(34)
	ldi r27,hi8(34)
	ldi r30,lo8(34)
	ldi r31,hi8(34)
	ld r24,Z
	ori r24,lo8(64)
	st X,r24
	call uart_wake
	ldi r26,lo8(40)
	ldi r27,hi8(40)
	ldi r30,lo8(40)
	ldi r31,hi8(40)
	ld r24,Z
	ori r24,lo8(16)
	st X,r24
	ldi r22,lo8(1250)
	ldi r23,hi8(1250)
	ldi r24,hlo8(1250)
	ldi r25,hhi8(1250)
	call delay_ms
	ldi r26,lo8(40)
	ldi r27,hi8(40)
	ldi r30,lo8(40)
	ldi r31,hi8(40)
	ld r24,Z
	andi r24,lo8(-17)
	st X,r24
	ldi r22,lo8(1750)
	ldi r23,hi8(1750)
	ldi r24,hlo8(1750)
	ldi r25,hhi8(1750)
	call delay_ms
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r25,Y+1
	ldi r24,lo8(1)
	eor r24,r25
	tst r24
	breq .L4
	lds r24,gm862_diagnostics
	lds r25,(gm862_diagnostics)+1
	lds r26,(gm862_diagnostics)+2
	lds r27,(gm862_diagnostics)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics,r24
	sts (gm862_diagnostics)+1,r25
	sts (gm862_diagnostics)+2,r26
	sts (gm862_diagnostics)+3,r27
.L4:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_wake size 95 (76) */
	.size	gm862_wake, .-gm862_wake
	.data
.LC2:
	.string	"AT#SHDN\r"
	.text
.global	gm862_sleep
	.type	gm862_sleep, @function
gm862_sleep:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	ldi r24,lo8(.LC2)
	ldi r25,hi8(.LC2)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(10000)
	ldi r21,hi8(10000)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r25,Y+1
	ldi r24,lo8(1)
	eor r24,r25
	tst r24
	breq .L8
	lds r24,gm862_diagnostics+4
	lds r25,(gm862_diagnostics+4)+1
	lds r26,(gm862_diagnostics+4)+2
	lds r27,(gm862_diagnostics+4)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+4,r24
	sts (gm862_diagnostics+4)+1,r25
	sts (gm862_diagnostics+4)+2,r26
	sts (gm862_diagnostics+4)+3,r27
.L8:
	call uart_sleep
	ldi r26,lo8(34)
	ldi r27,hi8(34)
	ldi r30,lo8(34)
	ldi r31,hi8(34)
	ld r24,Z
	andi r24,lo8(-65)
	st X,r24
	ldi r22,lo8(1000)
	ldi r23,hi8(1000)
	ldi r24,hlo8(1000)
	ldi r25,hhi8(1000)
	call delay_ms
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_sleep size 73 (54) */
	.size	gm862_sleep, .-gm862_sleep
	.data
.LC3:
	.string	"AT#SELINT=2\r"
.LC4:
	.string	"ATE\r"
.LC5:
	.string	"AT#BND="
.LC6:
	.string	"1"
.LC7:
	.string	"\r"
.LC8:
	.string	"AT+CGDCONT=1,\"IP\",\""
.LC9:
	.string	"wap.cingular"
.LC10:
	.string	"\",\"0.0.0.0\",1,1\r"
.LC11:
	.string	"AT#SCFG=1,1,"
.LC12:
	.string	"300"
.LC13:
	.string	"30"
.LC14:
	.string	"15"
.LC15:
	.string	"AT#NITZ=1,0\r"
.LC16:
	.string	"AT+CMGF=1\r"
.LC17:
	.string	"AT#ESMTP=\""
.LC18:
	.string	"\"\r"
.LC19:
	.string	"AT#EUSER=\""
.LC20:
	.string	"AT#EADDR=\""
.LC21:
	.string	"AT&P0\r"
.LC22:
	.string	"AT&W0\r"
	.text
.global	gm862_set_default_profile
	.type	gm862_set_default_profile, @function
gm862_set_default_profile:
/* prologue: frame size=5 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,5
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+3,r25
	std Y+2,r24
	ldi r24,lo8(.LC3)
	ldi r25,hi8(.LC3)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r24,Y+1
	tst r24
	breq .L12
	ldi r22,lo8(5000)
	ldi r23,hi8(5000)
	ldi r24,hlo8(5000)
	ldi r25,hhi8(5000)
	call delay_ms
.L12:
	ldd r24,Y+1
	tst r24
	breq .L14
	ldi r24,lo8(.LC4)
	ldi r25,hi8(.LC4)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L14:
	ldd r24,Y+1
	tst r24
	breq .L16
	ldi r24,lo8(.LC5)
	ldi r25,hi8(.LC5)
	call gm862_send_command
	ldi r24,lo8(.LC6)
	ldi r25,hi8(.LC6)
	call uart_send_string
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	call uart_send_string
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L16:
	ldd r24,Y+1
	tst r24
	breq .L18
	ldi r24,lo8(.LC8)
	ldi r25,hi8(.LC8)
	call gm862_send_command
	ldi r24,lo8(.LC9)
	ldi r25,hi8(.LC9)
	call uart_send_string
	ldi r24,lo8(.LC10)
	ldi r25,hi8(.LC10)
	call uart_send_string
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(15000)
	ldi r21,hi8(15000)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L18:
	ldd r24,Y+1
	tst r24
	breq .L20
	ldi r24,lo8(.LC11)
	ldi r25,hi8(.LC11)
	call gm862_send_command
	ldi r24,lo8(.LC12)
	ldi r25,hi8(.LC12)
	call uart_send_string
	ldi r24,lo8(44)
	call uart_send_byte
	ldi r24,lo8(.LC13)
	ldi r25,hi8(.LC13)
	call uart_send_string
	ldi r24,lo8(44)
	call uart_send_byte
	ldi r24,lo8(.LC12)
	ldi r25,hi8(.LC12)
	call uart_send_string
	ldi r24,lo8(44)
	call uart_send_byte
	ldi r24,lo8(.LC14)
	ldi r25,hi8(.LC14)
	call uart_send_string
	ldi r24,lo8(.LC7)
	ldi r25,hi8(.LC7)
	call uart_send_string
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L20:
	ldd r24,Y+1
	tst r24
	breq .L22
	ldi r24,lo8(.LC15)
	ldi r25,hi8(.LC15)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L22:
	ldd r24,Y+1
	tst r24
	breq .L24
	ldi r24,lo8(.LC16)
	ldi r25,hi8(.LC16)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(5000)
	ldi r21,hi8(5000)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L24:
	ldd r24,Y+1
	tst r24
	breq .L26
	ldi r24,lo8(.LC17)
	ldi r25,hi8(.LC17)
	call gm862_send_command
	ldd r30,Y+2
	ldd r31,Y+3
	ld r24,Z
	ldd r25,Z+1
	call uart_send_string
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call uart_send_string
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L26:
	ldd r24,Y+1
	tst r24
	breq .L28
	ldi r24,lo8(.LC19)
	ldi r25,hi8(.LC19)
	call gm862_send_command
	ldd r30,Y+2
	ldd r31,Y+3
	ldd r24,Z+2
	ldd r25,Z+3
	call uart_send_string
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call uart_send_string
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L28:
	ldd r24,Y+1
	tst r24
	breq .L30
	ldi r24,lo8(.LC20)
	ldi r25,hi8(.LC20)
	call gm862_send_command
	ldd r30,Y+2
	ldd r31,Y+3
	ldd r24,Z+6
	ldd r25,Z+7
	call uart_send_string
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call uart_send_string
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L30:
	ldd r24,Y+1
	tst r24
	breq .L32
	ldi r24,lo8(.LC21)
	ldi r25,hi8(.LC21)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L32:
	ldd r24,Y+1
	tst r24
	breq .L34
	ldi r24,lo8(.LC22)
	ldi r25,hi8(.LC22)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
.L34:
	ldd r24,Y+1
	ldi r25,lo8(1)
	eor r24,r25
	tst r24
	breq .L36
	lds r24,gm862_diagnostics+8
	lds r25,(gm862_diagnostics+8)+1
	lds r26,(gm862_diagnostics+8)+2
	lds r27,(gm862_diagnostics+8)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+8,r24
	sts (gm862_diagnostics+8)+1,r25
	sts (gm862_diagnostics+8)+2,r26
	sts (gm862_diagnostics+8)+3,r27
.L36:
	ldd r24,Y+1
	tst r24
	breq .L38
	call gm862_sleep
	call gm862_wake
	mov r18,r24
	clr r19
	std Y+5,r19
	std Y+4,r18
	rjmp .L40
.L38:
	std Y+5,__zero_reg__
	std Y+4,__zero_reg__
.L40:
	ldd r24,Y+4
	ldd r25,Y+5
/* epilogue: frame size=5 */
	adiw r28,5
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_set_default_profile size 358 (339) */
	.size	gm862_set_default_profile, .-gm862_set_default_profile
	.data
.LC23:
	.string	"AT+CREG?\r"
.LC24:
	.string	"+CREG: 0,1"
	.text
.global	gm862_gsm_registered
	.type	gm862_gsm_registered, @function
gm862_gsm_registered:
/* prologue: frame size=21 */
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,21
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=14) */
	ldi r24,lo8(.LC23)
	ldi r25,hi8(.LC23)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	movw r30,r28
	adiw r30,2
	mov __tmp_reg__,r31
	ldi r31,lo8(20)
	mov r14,r31
	clr r15
	mov r31,__tmp_reg__
	ldi r16,lo8(5000)
	ldi r17,hi8(5000)
	ldi r18,lo8(100)
	ldi r19,hi8(100)
	movw r20,r24
	ldi r22,lo8(20)
	ldi r23,hi8(20)
	movw r24,r30
	call uart_store_before_match_token
	std Y+1,r24
	ldd r24,Y+1
	tst r24
	breq .L43
	ldi r24,lo8(.LC24)
	ldi r25,hi8(.LC24)
	movw r18,r28
	subi r18,lo8(-(2))
	sbci r19,hi8(-(2))
	movw r22,r24
	movw r24,r18
	call strstr
	std Y+1,__zero_reg__
	sbiw r24,0
	breq .L43
	ldi r24,lo8(1)
	std Y+1,r24
.L43:
	ldd r24,Y+1
	ldi r25,lo8(1)
	eor r24,r25
	tst r24
	breq .L46
	lds r24,gm862_diagnostics+12
	lds r25,(gm862_diagnostics+12)+1
	lds r26,(gm862_diagnostics+12)+2
	lds r27,(gm862_diagnostics+12)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+12,r24
	sts (gm862_diagnostics+12)+1,r25
	sts (gm862_diagnostics+12)+2,r26
	sts (gm862_diagnostics+12)+3,r27
.L46:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=21 */
	adiw r28,21
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
/* epilogue end (size=13) */
/* function gm862_gsm_registered size 94 (67) */
	.size	gm862_gsm_registered, .-gm862_gsm_registered
	.data
.LC25:
	.string	"AT+CGATT?\r"
.LC26:
	.string	"+CGATT: 1"
	.text
.global	gm862_gprs_registered
	.type	gm862_gprs_registered, @function
gm862_gprs_registered:
/* prologue: frame size=21 */
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,21
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=14) */
	ldi r24,lo8(.LC25)
	ldi r25,hi8(.LC25)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	movw r30,r28
	adiw r30,2
	mov __tmp_reg__,r31
	ldi r31,lo8(20)
	mov r14,r31
	clr r15
	mov r31,__tmp_reg__
	ldi r16,lo8(5000)
	ldi r17,hi8(5000)
	ldi r18,lo8(100)
	ldi r19,hi8(100)
	movw r20,r24
	ldi r22,lo8(20)
	ldi r23,hi8(20)
	movw r24,r30
	call uart_store_before_match_token
	std Y+1,r24
	ldd r24,Y+1
	tst r24
	breq .L50
	ldi r24,lo8(.LC26)
	ldi r25,hi8(.LC26)
	movw r18,r28
	subi r18,lo8(-(2))
	sbci r19,hi8(-(2))
	movw r22,r24
	movw r24,r18
	call strstr
	std Y+1,__zero_reg__
	sbiw r24,0
	breq .L50
	ldi r24,lo8(1)
	std Y+1,r24
.L50:
	ldd r24,Y+1
	ldi r25,lo8(1)
	eor r24,r25
	tst r24
	breq .L53
	lds r24,gm862_diagnostics+16
	lds r25,(gm862_diagnostics+16)+1
	lds r26,(gm862_diagnostics+16)+2
	lds r27,(gm862_diagnostics+16)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+16,r24
	sts (gm862_diagnostics+16)+1,r25
	sts (gm862_diagnostics+16)+2,r26
	sts (gm862_diagnostics+16)+3,r27
.L53:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=21 */
	adiw r28,21
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
/* epilogue end (size=13) */
/* function gm862_gprs_registered size 94 (67) */
	.size	gm862_gprs_registered, .-gm862_gprs_registered
	.data
.LC27:
	.string	"AT+CSQ\r"
.LC28:
	.string	"+CSQ: "
	.text
.global	gm862_rssi
	.type	gm862_rssi, @function
gm862_rssi:
/* prologue: frame size=25 */
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,25
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=14) */
	ldi r24,lo8(.LC27)
	ldi r25,hi8(.LC27)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	movw r30,r28
	adiw r30,4
	mov __tmp_reg__,r31
	ldi r31,lo8(20)
	mov r14,r31
	clr r15
	mov r31,__tmp_reg__
	ldi r16,lo8(5000)
	ldi r17,hi8(5000)
	ldi r18,lo8(100)
	ldi r19,hi8(100)
	movw r20,r24
	ldi r22,lo8(20)
	ldi r23,hi8(20)
	movw r24,r30
	call uart_store_before_match_token
	std Y+3,r24
	ldd r24,Y+3
	tst r24
	breq .L57
	ldi r24,lo8(.LC28)
	ldi r25,hi8(.LC28)
	movw r18,r28
	subi r18,lo8(-(4))
	sbci r19,hi8(-(4))
	movw r22,r24
	movw r24,r18
	call strstr
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,0
	breq .L57
	ldd r24,Y+1
	ldd r25,Y+2
	movw r26,r24
	movw r30,r26
	ld __tmp_reg__,Z+
	tst __tmp_reg__
	brne .-6
	sbiw r30,1
	movw r24,r30
	sub r24,r26
	sbc r25,r27
	cpi r24,7
	cpc r25,__zero_reg__
	brlo .L57
	ldd r24,Y+1
	ldd r25,Y+2
	movw r30,r24
	adiw r30,6
	ld r24,Z
	clr r25
	sbrc r24,7
	com r25
	sbiw r24,48
	cpi r24,10
	cpc r25,__zero_reg__
	brsh .L57
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,6
	call atoi
	mov r18,r24
	clr r19
	std Y+25,r19
	std Y+24,r18
	rjmp .L62
.L57:
	lds r24,gm862_diagnostics+20
	lds r25,(gm862_diagnostics+20)+1
	lds r26,(gm862_diagnostics+20)+2
	lds r27,(gm862_diagnostics+20)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+20,r24
	sts (gm862_diagnostics+20)+1,r25
	sts (gm862_diagnostics+20)+2,r26
	sts (gm862_diagnostics+20)+3,r27
	ldi r24,lo8(99)
	ldi r25,hi8(99)
	std Y+25,r25
	std Y+24,r24
.L62:
	ldd r24,Y+24
	ldd r25,Y+25
/* epilogue: frame size=25 */
	adiw r28,25
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
/* epilogue end (size=13) */
/* function gm862_rssi size 130 (103) */
	.size	gm862_rssi, .-gm862_rssi
	.data
.LC29:
	.string	"AT+CCLK?\r"
.LC30:
	.string	"+CCLK: \""
	.text
.global	gm862_current_time
	.type	gm862_current_time, @function
gm862_current_time:
/* prologue: frame size=63 */
	push r10
	push r11
	push r12
	push r13
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,63
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=18) */
	ldi r24,lo8(6)
	movw r30,r28
	adiw r30,10
	movw r26,r30
	mov r25,r24
	st X+,__zero_reg__
        dec r25
	brne .-6
	ldi r24,lo8(.LC29)
	ldi r25,hi8(.LC29)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	movw r30,r28
	adiw r30,16
	mov __tmp_reg__,r31
	ldi r31,lo8(20)
	mov r14,r31
	clr r15
	mov r31,__tmp_reg__
	ldi r16,lo8(1500)
	ldi r17,hi8(1500)
	ldi r18,lo8(100)
	ldi r19,hi8(100)
	movw r20,r24
	ldi r22,lo8(35)
	ldi r23,hi8(35)
	movw r24,r30
	call uart_store_before_match_token
	std Y+3,r24
	ldd r24,Y+3
	tst r24
	brne .+2
	rjmp .L65
	ldi r24,lo8(.LC30)
	ldi r25,hi8(.LC30)
	movw r18,r28
	subi r18,lo8(-(16))
	sbci r19,hi8(-(16))
	movw r22,r24
	movw r24,r18
	call strstr
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,0
	brne .+2
	rjmp .L67
	ldd r24,Y+1
	ldd r25,Y+2
	movw r26,r24
	movw r30,r26
	ld __tmp_reg__,Z+
	tst __tmp_reg__
	brne .-6
	sbiw r30,1
	movw r24,r30
	sub r24,r26
	sbc r25,r27
	cpi r24,26
	cpc r25,__zero_reg__
	brlo .L67
	ldd r24,Y+1
	ldd r25,Y+2
	movw r30,r24
	adiw r30,7
	ld r24,Z
	cpi r24,lo8(34)
	brne .L67
	ldd r24,Y+1
	ldd r25,Y+2
	movw r30,r24
	adiw r30,25
	ld r24,Z
	cpi r24,lo8(34)
	brne .L67
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,8
	call atoi
	std Y+10,r24
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,11
	call atoi
	std Y+11,r24
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,14
	call atoi
	std Y+12,r24
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,17
	call atoi
	std Y+13,r24
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,20
	call atoi
	std Y+14,r24
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,23
	call atoi
	std Y+15,r24
	rjmp .L65
.L67:
	std Y+3,__zero_reg__
.L65:
	ldd r24,Y+3
	ldi r25,lo8(1)
	eor r24,r25
	tst r24
	breq .L72
	lds r24,gm862_diagnostics+24
	lds r25,(gm862_diagnostics+24)+1
	lds r26,(gm862_diagnostics+24)+2
	lds r27,(gm862_diagnostics+24)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+24,r24
	sts (gm862_diagnostics+24)+1,r25
	sts (gm862_diagnostics+24)+2,r26
	sts (gm862_diagnostics+24)+3,r27
.L72:
	movw r26,r28
	adiw r26,4
	std Y+52,r27
	std Y+51,r26
	movw r30,r28
	adiw r30,10
	std Y+54,r31
	std Y+53,r30
	ldi r31,lo8(6)
	std Y+55,r31
.L74:
	ldd r26,Y+53
	ldd r27,Y+54
	ld r0,X
	ldd r30,Y+53
	ldd r31,Y+54
	adiw r30,1
	std Y+54,r31
	std Y+53,r30
	ldd r26,Y+51
	ldd r27,Y+52
	st X,r0
	ldd r30,Y+51
	ldd r31,Y+52
	adiw r30,1
	std Y+52,r31
	std Y+51,r30
	ldd r31,Y+55
	subi r31,lo8(-(-1))
	std Y+55,r31
	ldd r24,Y+55
	tst r24
	brne .L74
	ldd r24,Y+4
	ldd r25,Y+5
	ldd r18,Y+6
	ldd r19,Y+7
	ldd r20,Y+8
	ldd r21,Y+9
	std Y+56,r24
	std Y+57,r25
	std Y+58,r18
	std Y+59,r19
	std Y+60,r20
	std Y+61,r21
	ldd r10,Y+56
	ldd r11,Y+57
	ldd r12,Y+58
	ldd r13,Y+59
	ldd r14,Y+60
	ldd r15,Y+61
	ldd r16,Y+62
	ldd r17,Y+63
	mov r18,r10
	mov r19,r11
	mov r20,r12
	mov r21,r13
	mov r22,r14
	mov r23,r15
	mov r24,r16
	mov r25,r17
/* epilogue: frame size=63 */
	adiw r28,63
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	pop r13
	pop r12
	pop r11
	pop r10
	ret
/* epilogue end (size=17) */
/* function gm862_current_time size 237 (202) */
	.size	gm862_current_time, .-gm862_current_time
	.data
.LC31:
	.string	"AT+CMGS=\""
.LC32:
	.string	"\r\n> "
	.text
.global	gm862_start_sms
	.type	gm862_start_sms, @function
gm862_start_sms:
/* prologue: frame size=3 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,3
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+3,r25
	std Y+2,r24
	ldi r24,lo8(.LC31)
	ldi r25,hi8(.LC31)
	call gm862_send_command
	ldd r24,Y+2
	ldd r25,Y+3
	call uart_send_string
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call uart_send_string
	ldi r24,lo8(.LC32)
	ldi r25,hi8(.LC32)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(5000)
	ldi r21,hi8(5000)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r24,Y+1
	tst r24
	breq .L77
	ldi r22,lo8(250)
	ldi r23,hi8(250)
	ldi r24,hlo8(250)
	ldi r25,hhi8(250)
	call delay_ms
.L77:
	ldd r24,Y+1
	ldi r25,lo8(1)
	eor r24,r25
	tst r24
	breq .L79
	lds r24,gm862_diagnostics+28
	lds r25,(gm862_diagnostics+28)+1
	lds r26,(gm862_diagnostics+28)+2
	lds r27,(gm862_diagnostics+28)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+28,r24
	sts (gm862_diagnostics+28)+1,r25
	sts (gm862_diagnostics+28)+2,r26
	sts (gm862_diagnostics+28)+3,r27
.L79:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=3 */
	adiw r28,3
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_start_sms size 79 (60) */
	.size	gm862_start_sms, .-gm862_start_sms
	.data
.LC33:
	.string	"\032"
	.text
.global	gm862_end_sms
	.type	gm862_end_sms, @function
gm862_end_sms:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	ldi r24,lo8(.LC33)
	ldi r25,hi8(.LC33)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(30000)
	ldi r21,hi8(30000)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r25,Y+1
	ldi r24,lo8(1)
	eor r24,r25
	tst r24
	breq .L83
	lds r24,gm862_diagnostics+32
	lds r25,(gm862_diagnostics+32)+1
	lds r26,(gm862_diagnostics+32)+2
	lds r27,(gm862_diagnostics+32)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+32,r24
	sts (gm862_diagnostics+32)+1,r25
	sts (gm862_diagnostics+32)+2,r26
	sts (gm862_diagnostics+32)+3,r27
.L83:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_end_sms size 60 (41) */
	.size	gm862_end_sms, .-gm862_end_sms
.global	gm862_send_sms
	.type	gm862_send_sms, @function
gm862_send_sms:
/* prologue: frame size=5 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,5
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+3,r25
	std Y+2,r24
	std Y+5,r23
	std Y+4,r22
	std Y+1,__zero_reg__
	ldd r24,Y+2
	ldd r25,Y+3
	call gm862_start_sms
	tst r24
	breq .L87
	ldd r24,Y+4
	ldd r25,Y+5
	call uart_send_string
	call gm862_end_sms
	std Y+1,r24
.L87:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=5 */
	adiw r28,5
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_send_sms size 39 (20) */
	.size	gm862_send_sms, .-gm862_send_sms
	.data
.LC34:
	.string	"AT#SGACT=1,1\r"
.LC35:
	.string	"#SGACT: "
	.text
.global	gm862_acquire_ip
	.type	gm862_acquire_ip, @function
gm862_acquire_ip:
/* prologue: frame size=43 */
	push r14
	push r15
	push r16
	push r17
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,43
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=14) */
	ldi r24,lo8(.LC34)
	ldi r25,hi8(.LC34)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	movw r30,r28
	adiw r30,10
	mov __tmp_reg__,r31
	ldi r31,lo8(20)
	mov r14,r31
	clr r15
	mov r31,__tmp_reg__
	ldi r16,lo8(10000)
	ldi r17,hi8(10000)
	ldi r18,lo8(100)
	ldi r19,hi8(100)
	movw r20,r24
	ldi r22,lo8(30)
	ldi r23,hi8(30)
	movw r24,r30
	call uart_store_before_match_token
	std Y+9,r24
	ldd r24,Y+9
	tst r24
	brne .+2
	rjmp .L91
	ldi r24,lo8(.LC35)
	ldi r25,hi8(.LC35)
	movw r18,r28
	subi r18,lo8(-(10))
	sbci r19,hi8(-(10))
	movw r22,r24
	movw r24,r18
	call strstr
	std Y+8,r25
	std Y+7,r24
	ldd r24,Y+7
	ldd r25,Y+8
	sbiw r24,0
	brne .+2
	rjmp .L91
	ldd r24,Y+7
	ldd r25,Y+8
	movw r26,r24
	movw r30,r26
	ld __tmp_reg__,Z+
	tst __tmp_reg__
	brne .-6
	sbiw r30,1
	movw r24,r30
	sub r24,r26
	sbc r25,r27
	cpi r24,15
	cpc r25,__zero_reg__
	brsh .+2
	rjmp .L91
	ldd r24,Y+7
	ldd r25,Y+8
	movw r30,r24
	adiw r30,8
	ld r24,Z
	clr r25
	sbrc r24,7
	com r25
	sbiw r24,48
	cpi r24,10
	cpc r25,__zero_reg__
	brlo .+2
	rjmp .L91
	ldd r24,Y+7
	ldd r25,Y+8
	adiw r24,8
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	call atoi
	clr r26
	sbrc r25,7
	com r26
	mov r27,r26
	mov r27,r24
	clr r26
	clr r25
	clr r24
	std Y+3,r24
	std Y+4,r25
	std Y+5,r26
	std Y+6,r27
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	ldi r22,lo8(46)
	ldi r23,hi8(46)
	call strchr
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,0
	breq .L96
	ldd r24,Y+1
	ldd r25,Y+2
	movw r26,r24
	movw r30,r26
	ld __tmp_reg__,Z+
	tst __tmp_reg__
	brne .-6
	sbiw r30,1
	movw r24,r30
	sub r24,r26
	sbc r25,r27
	cpi r24,6
	cpc r25,__zero_reg__
	brlo .L96
	ldd r24,Y+1
	ldd r25,Y+2
	movw r30,r24
	adiw r30,1
	ld r24,Z
	clr r25
	sbrc r24,7
	com r25
	sbiw r24,48
	cpi r24,10
	cpc r25,__zero_reg__
	brsh .L96
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	call atoi
	clr r26
	sbrc r25,7
	com r26
	mov r27,r26
	movw r20,r24
	clr r19
	clr r18
	ldd r24,Y+3
	ldd r25,Y+4
	ldd r26,Y+5
	ldd r27,Y+6
	or r24,r18
	or r25,r19
	or r26,r20
	or r27,r21
	std Y+3,r24
	std Y+4,r25
	std Y+5,r26
	std Y+6,r27
	rjmp .L100
.L96:
	std Y+9,__zero_reg__
.L100:
	ldd r24,Y+9
	tst r24
	brne .+2
	rjmp .L101
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	ldi r22,lo8(46)
	ldi r23,hi8(46)
	call strchr
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,0
	breq .L103
	ldd r24,Y+1
	ldd r25,Y+2
	movw r26,r24
	movw r30,r26
	ld __tmp_reg__,Z+
	tst __tmp_reg__
	brne .-6
	sbiw r30,1
	movw r24,r30
	sub r24,r26
	sbc r25,r27
	cpi r24,4
	cpc r25,__zero_reg__
	brlo .L103
	ldd r24,Y+1
	ldd r25,Y+2
	movw r30,r24
	adiw r30,1
	ld r24,Z
	clr r25
	sbrc r24,7
	com r25
	sbiw r24,48
	cpi r24,10
	cpc r25,__zero_reg__
	brsh .L103
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	call atoi
	clr r26
	sbrc r25,7
	com r26
	mov r27,r26
	clr r18
	mov r19,r24
	mov r20,r25
	mov r21,r26
	ldd r24,Y+3
	ldd r25,Y+4
	ldd r26,Y+5
	ldd r27,Y+6
	or r24,r18
	or r25,r19
	or r26,r20
	or r27,r21
	std Y+3,r24
	std Y+4,r25
	std Y+5,r26
	std Y+6,r27
	rjmp .L101
.L103:
	std Y+9,__zero_reg__
.L101:
	ldd r24,Y+9
	tst r24
	brne .+2
	rjmp .L107
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	ldi r22,lo8(46)
	ldi r23,hi8(46)
	call strchr
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,0
	breq .L109
	ldd r24,Y+1
	ldd r25,Y+2
	movw r26,r24
	movw r30,r26
	ld __tmp_reg__,Z+
	tst __tmp_reg__
	brne .-6
	sbiw r30,1
	movw r24,r30
	sub r24,r26
	sbc r25,r27
	cpi r24,2
	cpc r25,__zero_reg__
	brlo .L109
	ldd r24,Y+1
	ldd r25,Y+2
	movw r30,r24
	adiw r30,1
	ld r24,Z
	clr r25
	sbrc r24,7
	com r25
	sbiw r24,48
	cpi r24,10
	cpc r25,__zero_reg__
	brsh .L109
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	call atoi
	movw r18,r24
	clr r20
	sbrc r19,7
	com r20
	mov r21,r20
	ldd r24,Y+3
	ldd r25,Y+4
	ldd r26,Y+5
	ldd r27,Y+6
	or r24,r18
	or r25,r19
	or r26,r20
	or r27,r21
	std Y+3,r24
	std Y+4,r25
	std Y+5,r26
	std Y+6,r27
	rjmp .L107
.L109:
	std Y+9,__zero_reg__
.L107:
	ldd r24,Y+9
	tst r24
	breq .L91
	ldd r24,Y+3
	ldd r25,Y+4
	ldd r26,Y+5
	ldd r27,Y+6
	std Y+40,r24
	std Y+41,r25
	std Y+42,r26
	std Y+43,r27
	rjmp .L114
.L91:
	lds r24,gm862_diagnostics+36
	lds r25,(gm862_diagnostics+36)+1
	lds r26,(gm862_diagnostics+36)+2
	lds r27,(gm862_diagnostics+36)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+36,r24
	sts (gm862_diagnostics+36)+1,r25
	sts (gm862_diagnostics+36)+2,r26
	sts (gm862_diagnostics+36)+3,r27
	std Y+40,__zero_reg__
	std Y+41,__zero_reg__
	std Y+42,__zero_reg__
	std Y+43,__zero_reg__
.L114:
	ldd r24,Y+40
	ldd r25,Y+41
	ldd r26,Y+42
	ldd r27,Y+43
	movw r22,r24
	movw r24,r26
/* epilogue: frame size=43 */
	adiw r28,43
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16
	pop r15
	pop r14
	ret
/* epilogue end (size=13) */
/* function gm862_acquire_ip size 363 (336) */
	.size	gm862_acquire_ip, .-gm862_acquire_ip
	.data
.LC36:
	.string	"AT#SGACT=1,0\r"
	.text
.global	gm862_drop_ip
	.type	gm862_drop_ip, @function
gm862_drop_ip:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	ldi r24,lo8(.LC36)
	ldi r25,hi8(.LC36)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(1500)
	ldi r21,hi8(1500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r25,Y+1
	ldi r24,lo8(1)
	eor r24,r25
	tst r24
	breq .L117
	lds r24,gm862_diagnostics+40
	lds r25,(gm862_diagnostics+40)+1
	lds r26,(gm862_diagnostics+40)+2
	lds r27,(gm862_diagnostics+40)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+40,r24
	sts (gm862_diagnostics+40)+1,r25
	sts (gm862_diagnostics+40)+2,r26
	sts (gm862_diagnostics+40)+3,r27
.L117:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_drop_ip size 60 (41) */
	.size	gm862_drop_ip, .-gm862_drop_ip
	.data
.LC37:
	.string	"AT#EMAILD=\""
.LC38:
	.string	"\",\""
	.text
.global	gm862_start_email
	.type	gm862_start_email, @function
gm862_start_email:
/* prologue: frame size=5 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,5
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+3,r25
	std Y+2,r24
	std Y+5,r23
	std Y+4,r22
	ldi r24,lo8(.LC37)
	ldi r25,hi8(.LC37)
	call gm862_send_command
	ldd r24,Y+2
	ldd r25,Y+3
	call uart_send_string
	ldi r24,lo8(.LC38)
	ldi r25,hi8(.LC38)
	call uart_send_string
	ldd r24,Y+4
	ldd r25,Y+5
	call uart_send_string
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call uart_send_string
	ldi r24,lo8(.LC32)
	ldi r25,hi8(.LC32)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(5000)
	ldi r21,hi8(5000)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r24,Y+1
	tst r24
	breq .L121
	ldi r22,lo8(250)
	ldi r23,hi8(250)
	ldi r24,hlo8(250)
	ldi r25,hhi8(250)
	call delay_ms
.L121:
	ldd r24,Y+1
	ldi r25,lo8(1)
	eor r24,r25
	tst r24
	breq .L123
	lds r24,gm862_diagnostics+44
	lds r25,(gm862_diagnostics+44)+1
	lds r26,(gm862_diagnostics+44)+2
	lds r27,(gm862_diagnostics+44)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+44,r24
	sts (gm862_diagnostics+44)+1,r25
	sts (gm862_diagnostics+44)+2,r26
	sts (gm862_diagnostics+44)+3,r27
.L123:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=5 */
	adiw r28,5
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_start_email size 89 (70) */
	.size	gm862_start_email, .-gm862_start_email
.global	gm862_end_email
	.type	gm862_end_email, @function
gm862_end_email:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	ldi r24,lo8(.LC33)
	ldi r25,hi8(.LC33)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(-1)
	ldi r21,hi8(-1)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r25,Y+1
	ldi r24,lo8(1)
	eor r24,r25
	tst r24
	breq .L127
	lds r24,gm862_diagnostics+48
	lds r25,(gm862_diagnostics+48)+1
	lds r26,(gm862_diagnostics+48)+2
	lds r27,(gm862_diagnostics+48)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+48,r24
	sts (gm862_diagnostics+48)+1,r25
	sts (gm862_diagnostics+48)+2,r26
	sts (gm862_diagnostics+48)+3,r27
.L127:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_end_email size 60 (41) */
	.size	gm862_end_email, .-gm862_end_email
.global	gm862_send_email
	.type	gm862_send_email, @function
gm862_send_email:
/* prologue: frame size=7 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,7
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+3,r25
	std Y+2,r24
	std Y+5,r23
	std Y+4,r22
	std Y+7,r21
	std Y+6,r20
	std Y+1,__zero_reg__
	ldd r24,Y+4
	ldd r25,Y+5
	ldd r18,Y+2
	ldd r19,Y+3
	movw r22,r24
	movw r24,r18
	call gm862_start_email
	tst r24
	breq .L131
	ldd r24,Y+6
	ldd r25,Y+7
	call uart_send_string
	call gm862_end_email
	std Y+1,r24
.L131:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=7 */
	adiw r28,7
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_send_email size 45 (26) */
	.size	gm862_send_email, .-gm862_send_email
	.data
.LC39:
	.string	"AT#SD=1,0,"
.LC40:
	.string	",\""
.LC41:
	.string	"\r\nCONNECT\r\n"
	.text
.global	gm862_tcp_connect
	.type	gm862_tcp_connect, @function
gm862_tcp_connect:
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
	std Y+9,r25
	std Y+8,r24
	std Y+11,r23
	std Y+10,r22
	ldd r18,Y+10
	ldd r19,Y+11
	movw r24,r28
	adiw r24,2
	ldi r20,lo8(10)
	ldi r21,hi8(10)
	movw r22,r24
	movw r24,r18
	call itoa
	ldi r24,lo8(.LC39)
	ldi r25,hi8(.LC39)
	call gm862_send_command
	movw r24,r28
	adiw r24,2
	call uart_send_string
	ldi r24,lo8(.LC40)
	ldi r25,hi8(.LC40)
	call uart_send_string
	ldd r24,Y+8
	ldd r25,Y+9
	call uart_send_string
	ldi r24,lo8(.LC18)
	ldi r25,hi8(.LC18)
	call uart_send_string
	ldi r24,lo8(.LC41)
	ldi r25,hi8(.LC41)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(31500)
	ldi r21,hi8(31500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r25,Y+1
	ldi r24,lo8(1)
	eor r24,r25
	tst r24
	breq .L135
	lds r24,gm862_diagnostics+52
	lds r25,(gm862_diagnostics+52)+1
	lds r26,(gm862_diagnostics+52)+2
	lds r27,(gm862_diagnostics+52)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+52,r24
	sts (gm862_diagnostics+52)+1,r25
	sts (gm862_diagnostics+52)+2,r26
	sts (gm862_diagnostics+52)+3,r27
.L135:
	ldd r24,Y+1
	clr r25
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
/* function gm862_tcp_connect size 90 (71) */
	.size	gm862_tcp_connect, .-gm862_tcp_connect
	.data
.LC42:
	.string	"AT#SH=1\r"
	.text
.global	gm862_tcp_disconnect
	.type	gm862_tcp_disconnect, @function
gm862_tcp_disconnect:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	ldi r24,lo8(.LC42)
	ldi r25,hi8(.LC42)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(5000)
	ldi r21,hi8(5000)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r25,Y+1
	ldi r24,lo8(1)
	eor r24,r25
	tst r24
	breq .L139
	lds r24,gm862_diagnostics+56
	lds r25,(gm862_diagnostics+56)+1
	lds r26,(gm862_diagnostics+56)+2
	lds r27,(gm862_diagnostics+56)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+56,r24
	sts (gm862_diagnostics+56)+1,r25
	sts (gm862_diagnostics+56)+2,r26
	sts (gm862_diagnostics+56)+3,r27
.L139:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_tcp_disconnect size 60 (41) */
	.size	gm862_tcp_disconnect, .-gm862_tcp_disconnect
	.data
.LC43:
	.string	"+++"
	.text
.global	gm862_enter_command_mode
	.type	gm862_enter_command_mode, @function
gm862_enter_command_mode:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	ldi r22,lo8(2000)
	ldi r23,hi8(2000)
	ldi r24,hlo8(2000)
	ldi r25,hhi8(2000)
	call delay_ms
	ldi r24,lo8(.LC43)
	ldi r25,hi8(.LC43)
	call gm862_send_command
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	ldi r18,lo8(20)
	ldi r19,hi8(20)
	ldi r20,lo8(3500)
	ldi r21,hi8(3500)
	ldi r22,lo8(100)
	ldi r23,hi8(100)
	call uart_match_token
	std Y+1,r24
	ldd r25,Y+1
	ldi r24,lo8(1)
	eor r24,r25
	tst r24
	breq .L143
	lds r24,gm862_diagnostics+60
	lds r25,(gm862_diagnostics+60)+1
	lds r26,(gm862_diagnostics+60)+2
	lds r27,(gm862_diagnostics+60)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts gm862_diagnostics+60,r24
	sts (gm862_diagnostics+60)+1,r25
	sts (gm862_diagnostics+60)+2,r26
	sts (gm862_diagnostics+60)+3,r27
.L143:
	ldd r24,Y+1
	clr r25
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_enter_command_mode size 66 (47) */
	.size	gm862_enter_command_mode, .-gm862_enter_command_mode
.global	gm862_send_command
	.type	gm862_send_command, @function
gm862_send_command:
/* prologue: frame size=2 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,2
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+2,r25
	std Y+1,r24
	ldi r22,lo8(250)
	ldi r23,hi8(250)
	ldi r24,hlo8(250)
	ldi r25,hhi8(250)
	call delay_ms
	ldi r22,lo8(20)
	ldi r23,hi8(20)
	ldi r24,lo8(100)
	ldi r25,hi8(100)
	call uart_flush_rx
	ldd r24,Y+1
	ldd r25,Y+2
	call uart_send_string
/* epilogue: frame size=2 */
	adiw r28,2
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_send_command size 37 (18) */
	.size	gm862_send_command, .-gm862_send_command
.global	gm862_send_byte
	.type	gm862_send_byte, @function
gm862_send_byte:
/* prologue: frame size=1 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+1,r24
	ldd r24,Y+1
	call uart_send_byte
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_send_byte size 23 (4) */
	.size	gm862_send_byte, .-gm862_send_byte
.global	gm862_send_bytes
	.type	gm862_send_bytes, @function
gm862_send_bytes:
/* prologue: frame size=3 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,3
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+2,r25
	std Y+1,r24
	std Y+3,r22
	ldd r24,Y+1
	ldd r25,Y+2
	ldd r22,Y+3
	call uart_send_bytes
/* epilogue: frame size=3 */
	adiw r28,3
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_send_bytes size 27 (8) */
	.size	gm862_send_bytes, .-gm862_send_bytes
.global	gm862_send_string
	.type	gm862_send_string, @function
gm862_send_string:
/* prologue: frame size=2 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,2
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	call uart_send_string
/* epilogue: frame size=2 */
	adiw r28,2
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_send_string size 25 (6) */
	.size	gm862_send_string, .-gm862_send_string
.global	gm862_receive_byte
	.type	gm862_receive_byte, @function
gm862_receive_byte:
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
	std Y+2,r25
	std Y+1,r24
	std Y+4,r23
	std Y+3,r22
	ldd r24,Y+3
	ldd r25,Y+4
	ldd r18,Y+1
	ldd r19,Y+2
	movw r22,r24
	movw r24,r18
	call uart_receive_byte
	clr r25
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
/* function gm862_receive_byte size 32 (13) */
	.size	gm862_receive_byte, .-gm862_receive_byte
.global	gm862_receive_bytes
	.type	gm862_receive_bytes, @function
gm862_receive_bytes:
/* prologue: frame size=5 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,5
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* prologue end (size=10) */
	std Y+2,r25
	std Y+1,r24
	std Y+3,r22
	std Y+5,r21
	std Y+4,r20
	ldd r24,Y+4
	ldd r25,Y+5
	ldd r18,Y+1
	ldd r19,Y+2
	movw r20,r24
	ldd r22,Y+3
	movw r24,r18
	call uart_receive_bytes
	clr r25
/* epilogue: frame size=5 */
	adiw r28,5
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	ret
/* epilogue end (size=9) */
/* function gm862_receive_bytes size 34 (15) */
	.size	gm862_receive_bytes, .-gm862_receive_bytes
/* File "gm862.c": code 2317 = 0x090d (1794), prologues 274, epilogues 249 */
