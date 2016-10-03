	.file	"testCRC.c"
	.arch atmega644p
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
/* store size on the stack */
        ldi r20,0x11
        push r20
        ldi r20,0x00
        push r20

/* prologue end (size=10) */
	ldi r24,lo8(243)
	ldi r25,hi8(243)
	ldi r26,hlo8(243)
	ldi r27,hhi8(243)
	std Y+8,r24
	std Y+9,r25
	std Y+10,r26
	std Y+11,r27
	ldi r24,lo8(32)
	std Y+7,r24
	ldi r24,lo8(100)
	ldi r25,hi8(100)
	std Y+6,r25
	std Y+5,r24
	ldi r24,lo8(300)
	ldi r25,hi8(300)
	std Y+4,r25
	std Y+3,r24
	ldd r20,Y+5
	ldd r21,Y+6
	ldd r24,Y+7
	clr r25
	ldd r18,Y+8
	ldd r19,Y+9
	movw r22,r24
	movw r24,r18
	call a
	std Y+2,r25
	std Y+1,r24

.L2:
	rjmp .L2
/* epilogue: frame size=11 */
/* epilogue: noreturn */
/* epilogue end (size=0) */
/* function main size 41 (31) */
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


/* prologue: frame size=6 */
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
	sbiw r28,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
/* store the size of a */
        push r0
        push r0
        push r20
        push r21
        sbiw r28,1
        ldi r20,0xC
        std Y+1,r20
        ldi r21,0x0
        st Y,r21
        adiw r28,1
        pop r21
        pop r20
/* prologue end (size=10) */
	std Y+2,r25
	std Y+1,r24
	std Y+4,r23
	std Y+3,r22
	std Y+6,r21
	std Y+5,r20
	ldd r18,Y+1
	ldd r19,Y+2
	ldd r24,Y+3
	ldd r25,Y+4
	add r18,r24
	adc r19,r25
	ldd r24,Y+5
	ldd r25,Y+6
	add r24,r18
	adc r25,r19
/* epilogue: frame size=6 */
	adiw r28,6
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28

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
        sbiw r28,7
        st Y,r19
        std Y+1,r18
        adiw r28,7
        pop r19
        pop r18
/* calculate CRC end */
	ret
/* epilogue end (size=9) */
/* function a size 35 (16) */
	.size	a, .-a
/* File "testCRC.c": code   76 = 0x004c (  47), prologues  20, epilogues   9 */
