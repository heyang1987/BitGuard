/*
 * test_timer_interrupt.c
 *
 * Created: 12/9/2013 11:42:16 PM
 *  Author: Yang
 */ 
#include <avr/io.h>
#define F_CPU 10000000L


uint32_t counter = 0;
uint32_t i =0;
uint16_t size;
uint16_t addr;
uint8_t* p;
/*
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
*/
uint16_t fibonacci_recursive(uint16_t n)
{
	if (n == 0){
		return 0;
	}
	if (n == 1){
		return 1;
	}
	return fibonacci_recursive(n-1) + fibonacci_recursive(n-2);
}

int main(void){
	//uart_config_t uart_config = (uart_config_t){ 115200, NONE, 8, 1 };
	//uart_init(&uart_config);
	//uart_send_string("UART Ready.\r\n");
	// Timer0 configuration
	//TCCR0B |= (1<<CS00) | (1<<CS02);	// Prescaler set to 1024
	//TCCR0B |= (1<<CS02);	// Prescaler set to 256
	//TCCR0B |= (1<<CS01) | (1<<CS02);	// Prescaler set to 64
	//TCCR0B |= (1<<CS01);	// Prescaler set to 8
	TCCR0B |= (1<<CS00);	// Prescaler set to 1
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCNT1 = 0x00;			// Counter start from 0
	//sei();
	while(1){
		fibonacci_recursive(10);
	}
}

