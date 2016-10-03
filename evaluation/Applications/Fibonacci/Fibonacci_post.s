	.file	"Fibonacci.c"
__SP_H__ = 0x3e
__SP_L__ = 0x3d
__SREG__ = 0x3f
__tmp_reg__ = 0
__zero_reg__ = 1
.global	counter
	.section .bss
	.type	counter, @object
	.size	counter, 4
counter:
	.zero	4
.global	i
	.type	i, @object
	.size	i, 4
i:
	.zero	4
	.comm	size,2,1
	.comm	addr,2,1
	.comm	p,2,1
	.text
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
update:
        st Y,r26
        std Y+1,r27
        std Y+2,r26
        std Y+3,r27
        std Y+4,r26
        std Y+5,r27
        ret
vote:
        ld r26,Y
        ldd r27,Y+2
        cp r26,r27
        brne SPcheck_2and3 
        ldd r26,Y+1
        ldd r27,Y+3
        cp r26,r27
        brne SPcheck_2and3
        ldd r26,Y+2
        ret
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
        ret
choose_1or3:
        ld r26,Y
        ldd r27,Y+1
        ret
/* STP Update End */

/* Stack Frame Copy Segment */
copy:
        ld r1, Z+
        st X+, r1
        sbiw r24,1
        brne copy
        clr r1
        ret
/* Stack Frame Copy Segment End */


.global	fibonacci_recursive
	.type	fibonacci_recursive, @function
fibonacci_recursive:
/* crc prologue: backup 9 registers*/
        cli
        push r1
        push r1
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
        sbiw r28,5
        call vote
        movw r24,r26
        movw r26,r28
        adiw r28,5
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
        sbiw r28,9
        st Y,r19
        std Y+1,r18
        adiw r28,9
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
        sbiw r28,5
        movw r30,r28
        call vote
        movw r24,r26 
        adiw r28,5
/* STP Update */
        push r28
        push r29
        ldi r28,lo8(__snapshotSP_start)
        ldi r29,hi8(__snapshotSP_start)
	call vote
        call copy
        call update 
        pop r29
        pop r28
/* STP Update End */
        pop r31
        pop r30
        pop r27
        pop r26
        pop r25
        pop r24
        pop r1
/* memory copy end */

	push r16
	push r17
	push r28
	push r29
	rcall .
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 2 */
/* stack size = 6 */
/* Stack Frame Size Saving Segment */
        push r26
        push r26
        push r26
        push r26
        push r26
        push r26
        push r26
        ldi r26,0x0C
        sbiw r28,5
        st Y,r26
        std Y+2,r26
        std Y+4,r26
        ldi r26,0x0
        std Y+1,r26
        std Y+3,r26
        std Y+5,r26
        pop r26
        adiw r28,5
/* Stack Frame Size Saving Segment End */

.L__stack_usage = 6
	std Y+2,r25
	std Y+1,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,0
	brne .L2
	ldi r24,0
	ldi r25,0
	rjmp .L3
.L2:
	ldd r24,Y+1
	ldd r25,Y+2
	cpi r24,1
	cpc r25,__zero_reg__
	brne .L4
	ldi r24,lo8(1)
	ldi r25,0
	rjmp .L3
.L4:
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,1
	call fibonacci_recursive
	movw r16,r24
	ldd r24,Y+1
	ldd r25,Y+2
	sbiw r24,2
	call fibonacci_recursive
	add r24,r16
	adc r25,r17
.L3:
/* epilogue start */
	adiw r28,2
	in __tmp_reg__,__SREG__
	cli
	out __SP_H__,r29
	out __SREG__,__tmp_reg__
	out __SP_L__,r28
	pop r29
	pop r28
	pop r17
	pop r16

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
/* r25:r24 store the size of memory blocks to calculate,
r27:r26 store the starting address of the memory blocks, these blocks will be calculated in accending address order  */

        sbiw r28,5
        call vote
        movw r24,r26
        movw r26,r28
        adiw r28,5

        call crc

        pop r27
        pop r26
        pop r25
        pop r24
        pop r23
        pop r21
        pop r20
        sbiw r28,9
        ld r22,Y
        cp r22,r19
        brne memory_recover
        ldd r22,Y+1
        cp r22,r18
        brne memory_recover
        adiw r28,4
        call vote
        movw r24,r26
        push r28
        push r29
        ldi r28,lo8(__snapshotSP_start)
        ldi r29,hi8(__snapshotSP_start)
        call vote
        sub r26,r24
        sbc r27,r25
        call update
        adiw r28,9
        rjmp done

memory_recover:
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
        
        adiw r28,4
        call vote
        movw r24,r26
        push r28
        push r29
        ldi r28,lo8(__snapshotSP_start)
        ldi r29,hi8(__snapshotSP_start)
        call vote
        sub r26,r24
        sbc r27,r25
        call update
        movw r30,r26
        pop r29
        pop r28
        movw r26,r28
        call copy
        adiw r28,5
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
	.size	fibonacci_recursive, .-fibonacci_recursive
.global	main
	.type	main, @function
main:
	push r28
	push r29
	in r28,__SP_L__
	in r29,__SP_H__
/* prologue: function */
/* frame size = 0 */
/* stack size = 2 */
/* Stack Frame Size Saving Segment: save 3 copies */
        push r26
        push r26
        push r26
        push r26
        push r26
        push r26
        push r26
        ldi r26,0x0A
        sbiw r28,5
        st Y,r26
        std Y+2,r26
        std Y+4,r26
        ldi r26,0x0
        std Y+1,r26
        std Y+3,r26
        std Y+5,r26
        pop r26
        adiw r28,5
/* Stack Frame Size Saving Segment End */
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

.L__stack_usage = 2
	ldi r24,lo8(69)
	ldi r25,0
	ldi r18,lo8(69)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(1)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(110)
	ldi r25,0
	ldi r18,lo8(110)
	ldi r19,0
	movw r30,r18
	ld r18,Z
	ori r18,lo8(1)
	movw r30,r24
	st Z,r18
	ldi r24,lo8(-124)
	ldi r25,0
	movw r30,r24
	std Z+1,__zero_reg__
	st Z,__zero_reg__
.L6:
	ldi r24,lo8(10)
	ldi r25,0
	call fibonacci_recursive
	rjmp .L6
	.size	main, .-main
	.ident	"GCC: (AVR_8_bit_GNU_Toolchain_3.4.2_992) 4.7.2"
.global __do_clear_bss
