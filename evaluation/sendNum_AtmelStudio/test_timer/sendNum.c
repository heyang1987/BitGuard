#include <avr/io.h>
#include "uart.h"
#include <avr/interrupt.h>
#include <stdlib.h>
//#define F_CPU 10000000L

#define TTT (uint8_t)30
volatile uint16_t pre = TTT * 10;
volatile uint16_t counter = 0;
uint32_t num = 0;

ISR(TIMER0_OVF_vect) {
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
}

int main(void){
	uart_config_t uart_config = (uart_config_t){ 115200, NONE, 8, 1 };
	uart_init(&uart_config);
	uart_send_string("UART Ready.\n");
	// Timer0 configuration
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCNT1 = 0x00;			// Counter start from 0
	//TCCR0B |= (1<<CS00) | (1<<CS02);	// Prescaler set to 1024
	TCCR0B |= (1<<CS02);	// Prescaler set to 256
	sei();
	
	while(1){}
}
