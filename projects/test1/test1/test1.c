/*
 * test1.c
 *
 * Created: 9/10/2013 5:03:38 PM
 *  Author: jonas
 */ 
#include <util/delay.h>
#include <avr/interrupt.h>

uint32_t system_time;

int foo(char a, uint16_t b, int c);

 ISR(TIMER0_OVF_vect) {
	 system_time++;
 }

ISR(PCINT0_vect){
	//////////////////////////////////////////////////////////////////////////
	// This is the interrupt handler for rfm12 receiving messages.
	//////////////////////////////////////////////////////////////////////////
	uint8_t i = 0;
	if( !( PIND & _BV(PD5) ) ){
		i++;
	}
	
}

ISR(INT0_vect){
	uint16_t j = 1;
	j++;
}
ISR(INT1_vect){
	system_time--;
}

int main(void){
	system_time = 0;
	// Initialize timer0.
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCCR0B |= (1<<CS00);	// No prescaler
	// Enable interrupt.
	sei();
	uint32_t l;
	l = 243;
	uint8_t k;
	k = 32;	
	uint16_t i;
	i = 100;
	int j;	
	j=300;
	foo(1,i,j); 
	while(1){}   
}

int foo(char a, uint16_t b, int c){
	int x,y,z;
	x=a+c;
	y=c-a;
	z=x+y;
	return z;
}