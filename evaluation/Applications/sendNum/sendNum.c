#include <avr/io.h>
#include "uart.h"
#include <avr/interrupt.h>
#include <stdlib.h>
#define F_CPU 10000000L
#include <util/delay.h>
#include <avr/pgmspace.h>
#include "progmem1.h"


#define TTT (uint8_t)30
char err_str[] = "Your program has died a horrible death!";
volatile uint16_t pre = 1000;
volatile uint16_t counter = 0;
uint32_t intervalCounter = 0;
uint32_t num = 0;
uint32_t i =0;
uint16_t size;
uint16_t addr;
uint8_t* p;

ISR(TIMER0_OVF_vect) {
	uint8_t v=0;
	size = 0x10FF - (int) &v-18;
	intervalCounter++;
	if (intervalCounter== 10)
	{
		addr = 0x10FF-(int)pgm_read_byte(&(mydata[i++]))%size;
		p = (uint8_t *) addr;
		*p ^= 1 << 7;
                intervalCounter = 0;
	}
}

int main(void){
	uart_config_t uart_config = (uart_config_t){ 115200, NONE, 8, 1 };
	uart_init(&uart_config);
	//uart_send_string("UART Ready.\n");

	// Timer0 configuration
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCNT1 = 0x00;			// Counter start from 0
	//TCCR0B |= (1<<CS00);	// Prescaler set to 1
	//TCCR0B |= (1<<CS01);	// Prescaler set to 8
	//TCCR0B  |= (1<<CS00) | (1<<CS01);	// Prescaler set to 64
	//TCCR0B |= (1<<CS02);	// Prescaler set to 256
	TCCR0B |= (1<<CS00) | (1<<CS02);	// Prescaler set to 1024
	
    
    
    
	sei();
	
	while(1){

            char string[8];
	    if( counter >= pre ){
		itoa(num, string, 10);
		uart_send_string(string);
		uart_send_string("\n");
		num++;
		counter = 0;
	    } else {
		counter++;
	    }

            //uart_send_string("test\n");
            _delay_ms(1);
        }
}
