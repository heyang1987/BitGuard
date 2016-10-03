#include <avr/io.h>
#include <stdio.h>
#include "callerstack.h"

//#include <print_funcs.h>

uint8_t a=3;
uint16_t b=5;

extern uint16_t __snapshot_start;
    
int main(){
    //uint16_t *a = __snapshot_start;
    printf("0x%lx\n", (unsigned long)&__snapshot_start);
    while(1){}
    return 1;
}
