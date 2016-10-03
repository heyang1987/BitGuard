/*
 * test2.asm
 *
 *  Created: 9/10/2013 5:10:26 PM
 *   Author: jonas
 */ 

.nolist
.include "C:\Program Files (x86)\Atmel\Atmel Toolchain\AVR Assembler\Native\2.1.39.232\avrassembler\include\m644def.inc"
.list

.def	temp	=r16

		rjmp	Init

Init:
		ser		temp
		out		DDRB, temp
		out		DDRD, temp

		clr		temp
		out		PORTB, temp
		out		PORTB, temp

Start:
		sbi		PORTB, 0
		cbi		PORTB, 0
		rjmp	Start
