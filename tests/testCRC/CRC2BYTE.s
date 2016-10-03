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
   dec r20
   brne accumulate_crc16
