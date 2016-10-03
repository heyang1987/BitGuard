#include <avr/interrupt.h>
#include <avr/io.h>


uint32_t system_time;

void a();
int c(char a, uint16_t b, int c);

ISR(TIMER0_OVF_vect) {
	 system_time++;
}


ISR(INT0_vect){
	int i = 1;
	char j = 2;
	c(j, 10, i);
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

int c(char a, uint16_t b, int c){
	int x,y,z;
	x=a+c;
	y=c-a;
	z=x+y;
	return z;
}

