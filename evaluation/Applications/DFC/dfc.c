/*
 * test_timer_interrupt.c
 *
 * Created: 4/9/2013 11:42:16 PM
 *  Author: jonas
 */ 
#include <avr/io.h>
#define F_CPU 10000000L

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
	TCCR0B |= (1<<CS00) | (1<<CS02);	// Prescaler set to 102t
	TCNT1 = 0x00;			// Counter start from 0

	//sei();
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
