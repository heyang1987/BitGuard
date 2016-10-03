/*
 * CFile1.c
 *
 * Created: 12/11/2013 4:51:13 PM
 *  Author: Yang
 */ 

#include <avr/io.h>
//#include "uart.h"
//#include <avr/interrupt.h>
//#include <avr/pgmspace.h>
//#include "progmem1.h"

#define F_CPU 10000000L
/*
uint8_t counter = 0;
uint32_t i =0;
uint16_t size;
uint16_t addr;
uint8_t* p;

ISR(TIMER0_OVF_vect) {
	uint8_t v=0;
	size = 0x10FF - (int) &v-18;
	counter++;
	if (counter== 200)
	{
		addr = 0x10FF-(int)pgm_read_byte(&(mydata[i++]))%size;
		p = (uint8_t *) addr;
		*p ^= 1 << 7;
                counter = 0;
	}
}

ISR(TIMER0_OVF_vect) {
	uint8_t v;
	uart_send_byte((uint8_t)(((int) &v >> 8) & 0xFF));
	uart_send_byte((uint8_t)((int) &v & 0xFF));
	uart_send_string("\n");
}
*/
int a(){
	int i = 1;
	int j = 2;
	int k = i+j;
	int l = i+j+k;
	int m = i+j+k+l;
	int n = i+j+k+l+m;
	uint8_t u = 100;
	while(u>0){
		u--;
	}
	return n;
}

int main(void){
	//uart_config_t uart_config = (uart_config_t){ 115200, NONE, 8, 1 };
	//uart_init(&uart_config);
	TCCR0B |= (1<<CS00);	// Prescaler set to 1
	TCCR0B |= (1<<CS02);	// Prescaler set to 1024
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCNT1 = 0x00;			// Counter start from 0

//	sei();
	
	while(1){
		a();
		uint8_t u = 100;
		while(u>0){
			u--;
		}
	}
}
