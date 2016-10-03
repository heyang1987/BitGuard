; CRC16 parallel computation without using table
; data length in byte

main:
	ldi r18,0xFF
	ldi r19,0xFF
	ldi r20,0x13
	ldi r26, 0x0
	ldi r27, 0x01
        call accumulate_crc16
	
accumulate_crc16:
   ; r18: CRC low
   ; r19: CRC high
   ; Load the last CRC value, but swapped (low <-> high)
   ;lds r18, crc16_accumulator+1
   ;lds r19, crc16_accumulator
   ; First XOR
   ld r23, X+
   ; swap r18 and r19
   mov r25, r18
   mov r18, r19
   mov r19, r25
   
   eor r18, r23
  
   ; Second XOR
   mov r25, r18
   ; These 2 instructions are faster than executing 4 times "lsr 4".
   swap r25
   andi r25, 0x0F
   eor  r18, r25

   ; Third XOR
   mov r25, r18
   ; These 2 instructions are faster than executing 4 times "lsr 4".
   swap r25
   andi r25, 0xF0
   eor  r19, r25

   ; Fourth XOR
   mov  r25, r18
   swap r25
   mov  r24, r25
   andi r25, 0xF0
   andi r24, 0x0F
   lsl r25
   rol r24
   eor r18, r25
   eor r19, r24
   dec r20
   brne accumulate_crc16
     
   ;sts crc16_accumulator  , r18
   ;sts crc16_accumulator+1, r19
   ret
