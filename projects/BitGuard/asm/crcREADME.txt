CRC16 parallel computation without using table
Algorithm: CRC-16-CCITT, x16 + x12 + x5 + 1, 0x1021 / 0x8408 / 0x8810

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
   r18, r19, r24 and r25 are overwritten. 
   r20 is the low byte for datalength of data the calculate.
   r21 is the high byte for datalength of data the calculate.
   Assume X is pointing to the start address of the stack frame.

   r18: crc low
   r19: crc high