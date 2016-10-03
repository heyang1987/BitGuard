#include <avr/io.h>
#include <avr/interrupt.h>

uint32_t system_time;

void a();

ISR(TIMER0_OVF_vect) {
	 system_time++;
}


ISR(INT0_vect){
	uint16_t j = 1;
	j++;
}

int main(void){
	system_time = 0;
	// Initialize timer0.
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCCR0B |= (1<<CS00);	// No prescaler
	
	// INT0
	DDRD &= ~(1<<2);
	PORTD |= (1<<2);
	EIMSK |= (1<<INT0);	// Enable INT0
	EICRA = 0x00;	// The low level of INT0 and INT1 generates an interrupt request.

	// Enable interrupt.
	sei();

	uint16_t i;
	i = 100;
	int j;	
	j=300;
	a(); 

	while(1){}   
}

void a(){
	uint8_t i = 9;
	i++;
}
