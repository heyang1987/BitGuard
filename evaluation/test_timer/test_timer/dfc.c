/*
 * test_timer_interrupt.c
 *
 * Created: 4/9/2013 11:42:16 PM
 *  Author: jonas
 */ 
#include <avr/io.h>
//#include "uart.h"
#include <avr/interrupt.h>
#include <avr/pgmspace.h>
#include "progmem1.h"

#define F_CPU 10000000L

uint32_t counter = 0;
uint32_t i =0;
uint16_t size;
uint16_t addr;
uint8_t* p;

ISR(TIMER0_OVF_vect) {
	uint8_t v;
	size = 0x10FF - (int) &v;
	if (counter%200 == 0)
	{
		addr = 0x10FF-(int)pgm_read_byte(&(mydata[i++]))%size;
		p = (uint8_t *) addr;
		*p ^= 1 << 7;
	}
	counter++;
}
/*
ISR(TIMER0_OVF_vect) {
	uint8_t v;
	uart_send_byte((uint8_t)(((int) &v >> 8) & 0xFF));
	uart_send_byte((uint8_t)((int) &v & 0xFF));
	uart_send_string("\n");
}
*/
int a(){
	int i = 9;
	i = b();
	return i;
}

int b(){
	uint16_t i = 10;
	int j = 12;
	int k = c(1, i, j);
	k++;
	return k;
}

int c(int a, uint16_t b, int d){
	int x,y,z;
	x=a+d;
	y=d-a;
	z=x+y;
	return z;
}
int main(void){
	//uart_config_t uart_config = (uart_config_t){ 115200, NONE, 8, 1 };
	//uart_init(&uart_config);
	TCCR0B |= (1<<CS00);	// Prescaler set to 1
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCNT1 = 0x00;			// Counter start from 0

	sei();
	uint32_t l;
	l = 243;
	uint8_t k;
	k = 32;
	uint16_t i;
	i = 100;
	int j;
	j=300;
	while(1){
		int result = a();
		result++;
	}
}
