#include <avr/io.h>
#include <avr/interrupt.h>

#define F_CPU 10000000L

#define F_CPU 10000000L

uint16_t a();

ISR(TIMER0_OVF_vect) {
	uint8_t v;
	v++;
}

int main(){
	//uart_config_t uart_config = (uart_config_t){ 115200, NONE, 8, 1 };
	//uart_init(&uart_config);
	TCCR0B |= (1<<CS00);	// Prescaler set to 1
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCNT1 = 0x00;			// Counter start from 0

	sei();
    while(1){
		a();
    }
}

uint16_t a(){
    return SP;
}

