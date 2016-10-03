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

/* Stack Frame Size Saving Segment: 5 lines */
        ldi r1,0x11
        push r1
        ldi r1,0x00
        push r1
        clr r1
/* Stack Frame Size Saving End */
         
/* STP Initialization Segment, store 3 copy of snapshot_start */
        push r28
        push r29
        push r31
        ldi r28,lo8(__snapshotSP_start)
        ldi r29,hi8(__snapshotSP_start)
        ldi r31,lo8(__snapshot_start)
        st Y,r31
        std Y+2,r31
        std Y+4,r31
        ldi r31,hi8(__snapshot_start)
        std Y+1,r31
        std Y+3,r31
        std Y+5,r31
        pop r31
        pop r29
        pop r28
/* STP Initialization Segment End */
     
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

/* CRC Calculation Segment, Store crc value in r18,r19 */
crc:
	ld r23, X+
	mov r21, r18
	mov r18, r19
	mov r19, r21
	eor r18, r23
	mov r21, r18
	swap r21
	andi r21, 0x0F
	eor  r18, r21
	mov r21, r18
	swap r21
	andi r21, 0xF0
	eor  r19, r21
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
	brne crc
	ret
/* CRC Calculation Segment End */
/* Store r25:r24 Three times in the snapshotSP section */
store:
        st Y,r24
        std Y+1,r25
        std Y+2,r24
        std Y+3,r25
        std Y+4,r24
        std Y+5,r2
        ret
/* store end */
/* STP Update Segment */
updatestp:
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
        call store
/* STP Update End */

/* Stack Frame Copy Segment */
copy:
        ld r1, Z+
        st X+, r1
        sbiw r24,1
        brne copy
        ret
/* Stack Frame Copy Segment End */

.global	a
	.type	a, @function
a:
/* crc prologue: backup 9 registers*/
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
        ser r18
        ser r19
        sbiw r28,1
        movw r26,r28
        ld r25,Y
        ldd r24,Y+1
        adiw r28,1
/* crc prologue end */
        call crc 
/* crc epilogue */
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
/* crc epilogue end */

/* memory copy prologue*/
        push r1
        push r24
        push r25
        push r26
        push r27
        push r30
        push r31
        sbiw r28,1
        movw r30,r28
        ld r25,Y
        ldd r24,Y+1 
        adiw r28,1
/* STP Update */
        push r28
        push r29
	call updatestp
        pop r29
        pop r28
/* STP Update End */
        call copy
        
        pop r31
        pop r30
        pop r27
        pop r26
        pop r25
        pop r24
        pop r1
/* memory copy end */

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
/* Stack Frame Size Saving Segment: 6 lines */
        push r31
        ldi r31,0xC
        push r31
        ldi r31,0x0
        push r31
        pop r31
/* Stack Frame Size Saving Segment End */

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
        ser r18
        ser r19
/* 
 ** r25:r24 store the size of memory blocks to calculate
 ** r27:r26 store the starting address of the memory blocks, these blocks will be calculated in accending order 
*/
        ld r24,Y
        sbiw r28,1
        ld r25,Y
        mov r26,r28
        mov r27,r29
        adiw r28,1

        call crc

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
/* store the snapshot stack pointer in snapshotSP section 3 times */ 
        push r28
        push r29
        ldi r28,lo8(__snapshotSP_start)
        ldi r29,hi8(__snapshotSP_start)
        call store
        pop r29
        pop r28
/* store end */ 
        call copy

        pop r31
        pop r30
        pop r27
        pop r26
        pop r25
        pop r24
        pop r1
/* memory copy end */
done:
        pop r22
        pop r19
        pop r18
        pop r1
        pop r1
        clr r1
/* calculate CRC end */

	ret
/* epilogue end (size=9) */
/* function a size 35 (16) */
	.size	a, .-a
/* File "testCRC.c": code   76 = 0x004c (  47), prologues  20, epilogues   9 */
