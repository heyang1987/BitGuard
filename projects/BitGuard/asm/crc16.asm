; CRC16 parallel computation without using table
/* Algorithm: CRC-16-CCITT, x16 + x12 + x5 + 1, 0x1021 / 0x8408 / 0x8810

   Steps in C to update a running CRC with a new byte in ser_data:
   unsigned char ser_data;
   unsigned int crc;   -> accumulated CRC to update, initial value 0xFFFF
   crc  = (unsigned char)(crc >> 8) | (crc << 8);
   crc ^= ser_data;
   crc ^= (unsigned char)(crc & 0xff) >> 4;
   crc ^= (crc << 8) << 4;
   crc ^= ((crc & 0xff) << 4) << 1;
   Note that there are faster table-based implementations, but they
   consume more program space.
   r23 = new data byte to add to the CRC-16 checksum.
	The 16-bit variable crc16_accumulator (see below) holds the checksum,
	you should initialise its value to 0xFFFF before the first call to this routine.
	r18, r19, r24 and r25 are overwritten. r20 is the datalength of data the calculate.
	assume X is pointing to the start address of the stack frame.
*/

#define DataLength 0x02 ; data length in byte

crc16_init:
	ldi r18,$FF
	ldi r19,$FF
	ldi r20, DataLength
accumulate_crc16:
   ; r18: CRC low
   ; r19: CRC high
   ; Load the last CRC value, but swapped (low <-> high)
   ;lds r18, crc16_accumulator+1
   ;lds r19, crc16_accumulator
   ; First XOR
   ld r23, X+
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
next_data_byte:
   dec r20
   brne accumulate_crc16
   
   ;sts crc16_accumulator  , r18
   ;sts crc16_accumulator+1, r19
   ret