	.file	"sendNum.c"
	.arch atmega644p
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
.global	pre
	.section	.data.pre,"aw",@progbits
	.type	pre, @object
	.size	pre, 2
pre:
	.word	300
.global	counter
	.section	.bss.counter,"aw",@nobits
	.type	counter, @object
	.size	counter, 2
counter:
	.skip 2,0
.global	num
	.section	.bss.num,"aw",@nobits
	.type	num, @object
	.size	num, 4
num:
	.skip 4,0
	.data
.LC0:
	.string	"\n"
	.section	.text.__vector_18,"ax",@progbits
.global	__vector_18
	.type	__vector_18, @function
__vector_18:
/* calculate CRC */
        push 0x0
        push 0x0
        push r18
        push r19
        push r20
        push r21
        push r23
        push r24
        push r25
        push r26
        push r27
        ldi r18,0xFF
        ldi r19,0xFF
        ld r24,Y
        sbiw r28,1
        ld r25,Y
        adiw r28,1
        mov r26,r28
        dec r26
        mov r27,r29
accumulate_crc16:
	; r18: CRC low
	; r19: CRC high
	; Load the last CRC value, but swapped (low <-> high)
	;lds r18, crc16_accumulator+1
	;lds r19, crc16_accumulator
	; First XOR
	ld r23, X+
	; swap r18 and r19
	mov r21, r18
	mov r18, r19
	mov r19, r21

	eor r18, r23

	; Second XOR
	mov r21, r18
	; These 2 instructions are faster than executing 4 times "lsr 4".
	swap r21
	andi r21, 0x0F
	eor  r18, r21

	; Third XOR
	mov r21, r18
	; These 2 instructions are faster than executing 4 times "lsr 4".
	swap r21
	andi r21, 0xF0
	eor  r19, r21

	; Fourth XOR
	mov  r21, r18
	swap r21
	mov  r20, r21
	andi r21, 0xF0
	andi r20, 0x0F
	lsl r21
	rol r20
	eor r18, r21
	eor r19, r20
	sbiw r24,1
	brne accumulate_crc16

        pop r27
        pop r26
        pop r25
        pop r24
        pop r23
        pop r21
        pop r20
        sbiw r28,5
        st Y,r19
        std Y+1,r18
        adiw r28,5
        pop r19
        pop r18
/* calculate CRC end */
/* memory copy */
/* temp reg */
        push r1
/* memory blocks size */
        push r24
        push r25
/* destination address */
        push r26
        push r27
/* source address */
        push r30
        push r31
        ld r24,Y
        sbiw r28,1
        ld r25,Y
        mov r30,r28
        mov r31,r29
        adiw r28,1
/* snapshot stacker pointer voting process */
        push r28
        push r29
        ldi r28,lo8(__snapshotSP_start)
        ldi r29,hi8(__snapshotSP_start)
        ld r26,Y
        ldd r27,Y+2
        cp r26,r27
        brne SPcheck_2and3 
        ldd r26,Y+1
        ldd r27,Y+3
        cp r26,r27
        brne SPcheck_2and3
        ldd r26,Y+2
        rjmp store
SPcheck_2and3:
        ldd r26,Y+4
        ldd r27,Y+2
        cp r26,r27
        brne choose_1or3
        ldd r26,Y+5
        ldd r27,Y+3
        cp r26,r27
        brne choose_1or3
        ldd r26,Y+2
        rjmp store
choose_1or3:
        ld r26,Y
        ldd r27,Y+1
        rjmp store
/* voting end */
/* store  the snapshot stack pointer in snapshotSP section 3 times */
store:
        
        st Y,r24
        std Y+1,r25
        std Y+2,r24
        std Y+3,r25
        std Y+4,r24
        std Y+5,r25
        pop r29
        pop r28
/* store snapshot stack pointer 3 times end */

copy:
        ld r1, Z+
        st X+, r1
        sbiw r24,1
        brne copy
        
        pop r31
        pop r30
        pop r27
        pop r26
        pop r25
        pop r24
        pop r1
/* memory copy end */

/* prologue: frame size=8 */
	push __zero_reg__
	push __tmp_reg__
	in __tmp_reg__,__SREG__
	push __tmp_reg__
	clr __zero_reg__
	push r18
	push r19
	push r20
	push r21
	push r22
	push r23
	push r24
	push r25
	push r26
	push r27
	push r30
	push r31
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,8
	out __SP_H__,r29
	out __SP_L__,r28
/* store the size of INTERRUPT */
        push r0
        push r0
        push r20
        sbiw r28,1
        ldi r20,0xE
        std Y+1,r20
        ldi r20,0x0
        st Y,r20
        adiw r28,1
        pop r20

/* prologue end (size=24) */
	lds r18,counter
	lds r19,(counter)+1
	lds r24,pre
	lds r25,(pre)+1
	cp r18,r24
	cpc r19,r25
	brlo .L2
	lds r24,num
	lds r25,(num)+1
	lds r26,(num)+2
	lds r27,(num)+3
	movw r18,r24
	ldi r20,lo8(10)
	ldi r21,hi8(10)
	movw r24,r28
	adiw r24,1
	movw r22,r24
	movw r24,r18
	call itoa
	movw r24,r28
	adiw r24,1
	call uart_send_string
	ldi r24,lo8(.LC0)
	ldi r25,hi8(.LC0)
	call uart_send_string
	lds r24,num
	lds r25,(num)+1
	lds r26,(num)+2
	lds r27,(num)+3
	adiw r24,1
	adc r26,__zero_reg__
	adc r27,__zero_reg__
	sts num,r24
	sts (num)+1,r25
	sts (num)+2,r26
	sts (num)+3,r27
	sts (counter)+1,__zero_reg__
	sts counter,__zero_reg__
	rjmp .L5
.L2:
	lds r24,counter
	lds r25,(counter)+1
	adiw r24,1
	sts (counter)+1,r25
	sts counter,r24
.L5:
/* epilogue: frame size=8 */
	adiw r28,8
	cli
	out __SP_H__,r29
	out __SP_L__,r28
	pop r29
	pop r28
	pop r31
	pop r30
	pop r27
	pop r26
	pop r25
	pop r24
	pop r23
	pop r22
	pop r21
	pop r20
	pop r19
	pop r18
	pop __tmp_reg__
	out __SREG__,__tmp_reg__
	pop __tmp_reg__
	pop __zero_reg__

/* calculate CRC */
        push r18
        push r19
        push r22
        push r20
        push r21
        push r23
        push r24
        push r25
        push r26
        push r27
        ldi r18,0xFF
        ldi r19,0xFF
/* 
 ** r25:r24 store the size of memory blocks need to be calculated
 ** r27:r26 store the starting address of the memory blocks, these blocks will be calculated in accending order 
*/
        ld r24,Y
        sbiw r28,1
        ld r25,Y
        mov r26,r28
        mov r27,r29
        adiw r28,1
crc2:
	; r18: CRC low
	; r19: CRC high
	; Load the last CRC value, but swapped (low <-> high)
	;lds r18, crc16_accumulator+1
	;lds r19, crc16_accumulator
	; First XOR
	ld r23, X+
	; swap r18 and r19
	mov r21, r18
	mov r18, r19
	mov r19, r21

	eor r18, r23

	; Second XOR
	mov r21, r18
	; These 2 instructions are faster than executing 4 times "lsr 4".
	swap r21
	andi r21, 0x0F
	eor  r18, r21

	; Third XOR
	mov r21, r18
	; These 2 instructions are faster than executing 4 times "lsr 4".
	swap r21
	andi r21, 0xF0
	eor  r19, r21

	; Fourth XOR
	mov  r21, r18
	swap r21
	mov  r20, r21
	andi r21, 0xF0
	andi r20, 0x0F
	lsl r21
	rol r20
	eor r18, r21
	eor r19, r20
	sbiw r24,1
	brne crc2

        pop r27
        pop r26
        pop r25
        pop r24
        pop r23
        pop r21
        pop r20
        sbiw r28,5
        ld r22,Y
        cp r22,r19
        brne memory_recover
        ldd r22,Y+1
        cp r22,r18
        brne memory_recover
        adiw r28,5
        rjmp done

memory_recover:
        adiw r28,5
/* memory copy */
/* temp reg */
        push r1
/* memory blocks size */
        push r24
        push r25
/* destination address */
        push r26
        push r27
/* source address */
        push r30
        push r31

        ld r24,Y
        sbiw r28,1
        ld r25,Y
        ldi r30,lo8(__snapshot_start)
        ldi r31,hi8(__snapshot_start)
        mov r26,r28
        mov r27,r29
        adiw r28,1
/* store  the snapshot stack pointer in snapshotSP section 3 times 
        push r28
        push r29
        ldi r28,lo8(__snapshotSP_start)
        ldi r29,hi8(__snapshotSP_start)
        st Y,r24
        std Y+1,r25
        std Y+2,r24
        std Y+3,r25
        std Y+4,r24
        std Y+5,r25
        pop r29
        pop r28
*/
recover:
        ld r1, Z+
        st X+, r1
        sbiw r24,1
        brne recover


        pop r31
        pop r30
        pop r27
        pop r26
        pop r25
        pop r24
        pop r1
/* memory copy end */

        rjmp done

done:
        pop r22
        pop r19
        pop r18
        pop r1
        pop r1
        clr r1
/* calculate CRC end */

	reti
/* epilogue end (size=23) */
/* function __vector_18 size 116 (69) */
	.size	__vector_18, .-__vector_18
	.section	.rodata.C.5.1474,"a",@progbits
	.type	C.5.1474, @object
	.size	C.5.1474, 7
C.5.1474:
	.byte	0
	.byte	-62
	.byte	1
	.byte	0
	.byte	0
	.byte	8
	.byte	1
	.data
.LC1:
	.string	"UART Ready.\n"
	.section	.text.main,"ax",@progbits
.global	main
	.type	main, @function
main:
/* prologue: frame size=24 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,24
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* store size on the stack */
        ldi r20,0x1E
        push r20
        ldi r20,0x00
        push r20
/* store the snapshot stack pointer address in the snapshotSP section */
        push r28
        push r29
        push r24
        push r25
        ldi r28,lo8(__snapshotSP_start)
        ldi r29,hi8(__snapshotSP_start)
        ldi r24,lo8(__snapshot_start)
        ldi r25,hi8(__snapshot_start)
        st Y,r24
        std Y+1,r25
        std Y+2,r24
        std Y+3,r25
        std Y+4,r24
        std Y+5,r25
        pop r25
        pop r24
        pop r29
        pop r28
/* prologue end (size=10) */
	movw r24,r28
	adiw r24,1
	std Y+16,r25
	std Y+15,r24
	ldi r30,lo8(C.5.1474)
	ldi r31,hi8(C.5.1474)
	std Y+18,r31
	std Y+17,r30
	ldi r31,lo8(7)
	std Y+19,r31
.L7:
	ldd r30,Y+17
	ldd r31,Y+18
	ld r0,Z
	ldd r24,Y+17
	ldd r25,Y+18
	adiw r24,1
	std Y+18,r25
	std Y+17,r24
	ldd r30,Y+15
	ldd r31,Y+16
	st Z,r0
	ldd r24,Y+15
	ldd r25,Y+16
	adiw r24,1
	std Y+16,r25
	std Y+15,r24
	ldd r25,Y+19
	subi r25,lo8(-(-1))
	std Y+19,r25
	ldd r30,Y+19
	tst r30
	brne .L7
	movw r24,r28
	adiw r24,8
	std Y+21,r25
	std Y+20,r24
	movw r30,r28
	adiw r30,1
	std Y+23,r31
	std Y+22,r30
	ldi r31,lo8(7)
	std Y+24,r31
.L8:
	ldd r30,Y+22
	ldd r31,Y+23
	ld r0,Z
	ldd r24,Y+22
	ldd r25,Y+23
	adiw r24,1
	std Y+23,r25
	std Y+22,r24
	ldd r30,Y+20
	ldd r31,Y+21
	st Z,r0
	ldd r24,Y+20
	ldd r25,Y+21
	adiw r24,1
	std Y+21,r25
	std Y+20,r24
	ldd r25,Y+24
	subi r25,lo8(-(-1))
	std Y+24,r25
	ldd r30,Y+24
	tst r30
	brne .L8
	movw r24,r28
	adiw r24,8
	call uart_init
	ldi r24,lo8(.LC1)
	ldi r25,hi8(.LC1)
	call uart_send_string
	ldi r26,lo8(110)
	ldi r27,hi8(110)
	ldi r30,lo8(110)
	ldi r31,hi8(110)
	ld r24,Z
	ori r24,lo8(1)
	st X,r24
	ldi r30,lo8(132)
	ldi r31,hi8(132)
	std Z+1,__zero_reg__
	st Z,__zero_reg__
	ldi r26,lo8(69)
	ldi r27,hi8(69)
	ldi r30,lo8(69)
	ldi r31,hi8(69)
	ld r24,Z
	ori r24,lo8(4)
	st X,r24
/* #APP */
	sei
/* #NOAPP */
.L9:
	rjmp .L9
/* epilogue: frame size=24 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 103 (93) */
	.size	main, .-main
/* File "sendNum.c": code  219 = 0x00db ( 162), prologues  34, epilogues  23 */
