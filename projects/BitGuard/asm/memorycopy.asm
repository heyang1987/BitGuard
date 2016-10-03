;R1: temporary data storage
;R24: ramsize, size of data block to copy
;R25: ramsize high byte, size of the data block to copy
;R26: XL, destination address low byte
;R27: XH, destination address high byte
;R30: ZL, source address low byte
;R31: ZH, source address high byte

copy_init:
   ldi r24, $10
   ldi r25, $00
   ldi XL, $10
   ldi XH, $01
   ldi ZL, $00
   ldi ZH, $01

copy:
   ld R1, Z+
   st X+, R1
   sbiw r24,1
   brne copy

complete:
   nop  

   
