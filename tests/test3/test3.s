	.file	"test3.c"
	.arch atmega644p
__SREG__ = 0x3f
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__tmp_reg__ = 0
__zero_reg__ = 1
	.global __do_copy_data
	.global __do_clear_bss
	.text
.global	__vector_18
	.type	__vector_18, @function
__vector_18:
/* prologue: frame size=0 */
	push __zero_reg__
	push __tmp_reg__
	in __tmp_reg__,__SREG__
	push __tmp_reg__
	clr __zero_reg__
	push r24
	push r25
	push r26
	push r27
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue end (size=13) */
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
/* epilogue: frame size=0 */
	pop r29
	pop r28
	pop r27
	pop r26
	pop r25
	pop r24
	pop __tmp_reg__
	out __SREG__,__tmp_reg__
	pop __tmp_reg__
	pop __zero_reg__
	reti
/* epilogue end (size=11) */
/* function __vector_18 size 43 (19) */
	.size	__vector_18, .-__vector_18
.global	__vector_1
	.type	__vector_1, @function
__vector_1:
/* prologue: frame size=2 */
	push __zero_reg__
	push __tmp_reg__
	in __tmp_reg__,__SREG__
	push __tmp_reg__
	clr __zero_reg__
	push r24
	push r25
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,2
	out __SP_H__,r29
	out __SP_L__,r28
/* prologue end (size=14) */
	ldi r24,lo8(1)
	ldi r25,hi8(1)
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	adiw r24,1
	std Y+2,r25
	std Y+1,r24
/* epilogue: frame size=2 */
	adiw r28,2
	cli
	out __SP_H__,r29
	out __SP_L__,r28
	pop r29
	pop r28
	pop r25
	pop r24
	pop __tmp_reg__
	out __SREG__,__tmp_reg__
	pop __tmp_reg__
	pop __zero_reg__
	reti
/* epilogue end (size=13) */
/* function __vector_1 size 36 (9) */
	.size	__vector_1, .-__vector_1
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
/* store size on the stack */
        ldi r20,0x11
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
	ldi r26,lo8(42)
	ldi r27,hi8(42)
	ldi r30,lo8(42)
	ldi r31,hi8(42)
	ld r24,Z
	andi r24,lo8(-5)
	st X,r24
	ldi r26,lo8(43)
	ldi r27,hi8(43)
	ldi r30,lo8(43)
	ldi r31,hi8(43)
	ld r24,Z
	ori r24,lo8(4)
	st X,r24
	ldi r26,lo8(61)
	ldi r27,hi8(61)
	ldi r30,lo8(61)
	ldi r31,hi8(61)
	ld r24,Z
	ori r24,lo8(1)
	st X,r24
	ldi r30,lo8(105)
	ldi r31,hi8(105)
	st Z,__zero_reg__
/* #APP */
	sei
/* #NOAPP */
	ldi r24,lo8(100)
	ldi r25,hi8(100)
	std Y+4,r25
	std Y+3,r24
	ldi r24,lo8(300)
	ldi r25,hi8(300)
	std Y+2,r25
	std Y+1,r24
	call a
.L6:
	rjmp .L6
/* epilogue: frame size=4 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 69 (59) */
	.size	main, .-main
.global	a
	.type	a, @function
a:
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
/* store the size of a */
        push r20
        push r21
        ldi r20,0xC
        ldi r21,0x0
        push r20
        push r21
        pop r21
        pop r20

/* prologue end (size=10) */
	ldi r24,lo8(9)
	std Y+1,r24
	ldd r24,Y+1
	subi r24,lo8(-(1))
	std Y+1,r24
/* epilogue: frame size=1 */
	adiw r28,1
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28

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

	ret
/* epilogue end (size=9) */
/* function a size 24 (5) */
	.size	a, .-a
	.comm system_time,4,1
/* File "test3.c": code  172 = 0x00ac (  92), prologues  47, epilogues  33 */
