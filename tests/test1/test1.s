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