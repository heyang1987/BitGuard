/*
 * CFile1.c
 *
 * Created: 12/11/2013 4:51:13 PM
 *  Author: Yang
 */ 

#include <avr/io.h>
#include "uart.h"
#include <avr/interrupt.h>
#include <stdlib.h>
#include <avr/pgmspace.h>
#include "progmem1.h"

#define F_CPU 10000000L

int counter = 0;
int i =0;
int size;
int pos;
uint8_t* p;
ISR(TIMER0_OVF_vect) {
	uint8_t v;
	size = 0x10FF - (int) &v;
	if (counter%200 == 0)
	{
		pos = 0x10FF-(int)pgm_read_byte(&(mydata[i++]))%size;                      
		p = (uint8_t *) pos;
		uart_send_byte(*p);
		//uart_send_string("\r");
		*p ^= 1 << 7;
		uart_send_byte(*p);
		//uart_send_string("\n");
	}
	/*
	uart_send_byte((uint8_t)((size >> 8) & 0xFF));
	uart_send_byte((uint8_t)(size & 0xFF));
	uart_send_string("\n");
	*/
	counter++;
}
int a(){
	int i = 1;
	int j = 2;
	int k = i+j;
	int l = i+j+k;
	int m = i+j+k+l;
	int n = i+j+k+l+m;
	uint32_t u = 200;
	while(u>0){
		u--;
	}
	return n;
}

int main(void){
	uart_config_t uart_config = (uart_config_t){ 115200, NONE, 8, 1 };
	uart_init(&uart_config);
	TCCR0B |= (1<<CS00);	// Prescaler set to 1
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCNT1 = 0x00;			// Counter start from 0

	sei();
	
	while(1){
		a();
		uint32_t u = 200;
		while(u>0){
			u--;
		}
	}
}
