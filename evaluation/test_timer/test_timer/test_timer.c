/*
 * test_timer.c
 *
 * Created: 3/20/2013 8:28:59 PM
 *  Author: jonas
 */ 

#include <avr/io.h>
#include <avr/interrupt.h>
#include <avr/delay.h>
#include "test_timer.h"
#include "uart.h"
#include "mma8452.h"
#include "i2c.h"

#define F_CPU 8000000L
static volatile uint8_t timer_update = 0;
volatile uint8_t timer_flag = 0;

volatile uint8_t pin0_update = 0;
volatile uint8_t pin0_flag = 0;

volatile uint8_t pin1_update = 0;
volatile uint8_t pin1_flag = 0;

volatile uint8_t pressure_sensor_id = 1;

static test_struct_t test_struct = {.start = 0x0A, .middle = 0x0B};

uint8_t timer_counter = 0;
//ISR(ADC_vect)
// timer0 overflow
/*
ISR(TIMER0_OVF_vect) {
	if( timer_counter >= 3 ){
		timer_update = 1;
		if( timer_flag == 0 ){
			timer_flag = 1;
		} else {
			timer_flag = 0;
		}
		timer_counter = 0;
	} else {
		timer_counter++;
	}
}
*/
/*
ISR(PCINT0_vect){
	if( PINB & _BV(PB0) ){
		pin0_update = 1;
		if( pin0_flag == 0 ){
			pin0_flag = 1;
		} else {
			pin0_flag = 0;
		}
	} else 	if( PINB & _BV(PB1) ){
		pin1_update = 1;
		if( pin1_flag == 0 ){
			pin1_flag = 1;
		} else {
			pin1_flag = 0;
		}
	}
	_delay_ms(10);
}
*/
// ADC conversion complete interrupt
//SIGNAL(SIG_ADC) {
ISR(ADC_vect){
	pin0_update = 1;
		if( pin0_flag == 0 ){
			pin0_flag = 1;
		} else {
			pin0_flag = 0;
		}
	
	//PORTB = B3;
	uint16_t sample;

	// retrieve the ADC sample
	sample = ADCL;
	sample |= (ADCH << 8);
	
	//float t = sample * 0.488 - 50;
	//uint16_t t = sample / 2 - 50;
	
	char result[50];
	//sprintf(result,"%X + %X = %d: %d", ADCL, ADCH, sample, (uint16_t)t);
	sprintf(result,">>%d: %X + %X = %d\r\n", pressure_sensor_id, ADCL, ADCH, sample);
	
	uart_send_string(result);
	
	// disable the ADC unit
	//ADCSRA &= ~(1 << ADEN);
}

int16_t result[3];
uint8_t data[256];
void test_mma8452(){
		// Initialize uart
	uart_config_t uart_config = (uart_config_t){ 9600, NONE, 8, 1 };
	uart_init(&uart_config);
	
	i2c_init();
	
	uart_send_string("UART initialized.\r\n");
	// Initialize mma8452
	uint8_t result_flag = mma8452_init();
	if(result_flag){
		uart_send_string("MMA8452 initialized.\r\n");
	}
	mma8452_standby();
	mma8452_fast_mode_disable();
	mma8452_scale_4g();
//	mma8452_set_mode_normal();
	mma8452_set_data_rate(4);
	mma8452_low_noise_enable();
	mma8452_active();
	
	
	while(1){
		if( mma8452_is_xyz_data_ready() > 0 ){
			mma8452_read_xyz_acceleration(&result[0]);
			
			sprintf(data, "%d:%d:%d\n", result[0], result[1], result[2]);
			//data_local.count = strlen(data);
			//transmit(&data_local,'D',255);
			
			uart_send_string(data);
		}
		_delay_ms(500);
	}
}

void adc_init(){
	ADMUX |= (1<<REFS0);
	
	// enable ADC unit;
	ADCSRA |= (1 << ADEN);
	// enable ADC interrupt;
	ADCSRA |= (1 << ADIE);
	
	ADCSRA |= (1<<ADATE);
	
	ADCSRB |= (1<<ADTS2);
	
	//ADCSRA |= (1<<ADSC);
	
	sei();
}
uint8_t start_sample(uint8_t pressure_sensor_id){
	if( pressure_sensor_id > 2 ){
		return 0;
	}
	if( pressure_sensor_id == 1 ){
		ADMUX &= 0xF0;	// Select ADC0
	} else {
		ADMUX &= 0xF0;
		ADMUX |= ( 1<<MUX0 );	// Select ADC1
	}
	ADCSRA |= ( 1<<ADEN );	// Enable ADC
	ADCSRA |= ( 1<<ADIE );	// Enable ADC interrupt
	sei();
	
	ADCSRA |= (1 << ADSC);  // Start ADC Conversions 
	return 1;
}

void sample_pressure_sensor_1(){
	start_sample(1);	
}

void sample_pressure_sensor_2(){
	start_sample(2);
}


int main1(void)
{
	//test_mma8452();
	uart_config_t uart_config = (uart_config_t){ 9600, NONE, 8, 1 };
	uart_init(&uart_config);
	uart_send_string("UART Ready.\r\n");
	
    DDRB |= (1<<6) | (1<<7);
	DDRD |= (1<<5);
	
	PORTB |= (1<<6) | (1<<7); 
	PORTD |= (1<<5);
	_delay_ms(8000);
	PORTB &= ~(1<<6);
	PORTB &= ~(1<<7);
	PORTD &= ~(1<<5);
	
	// Timer0 configuration
	TIMSK0 |= (1<<TOIE0);	// Enable timer0 interrupt
	TCNT1 = 0x00;			// Counter start from 0
	TCCR0B |= (1<<CS00) | (1<<CS02);	// Prescaler set to 1024
	
	// PCINT0 configuration
	PCICR |= (1<<PCIE0);
	PCMSK0 |= (1<<PCINT0) | (1<<PCINT1);
	
	//adc_init();
	// Enable interrupt.
	sei();
    while(1)
    {
		if( timer_update == 1 ){
			if( timer_flag == 1 ){
				PORTB |= (1<<6);
				pressure_sensor_id = 1;				
				sample_pressure_sensor_1();
			} else {
				PORTB &= ~(1<<6);
				pressure_sensor_id = 2;
				sample_pressure_sensor_2();				
			}
			timer_update = 0;
		}
		if( pin0_update ){
			if( pin0_flag == 1 ){
				PORTD |= (1<<5);
			} else {
				PORTD &= ~(1<<5);
			}
			pin0_update = 0;
		}
		if( pin1_update ){
			
			if( pin1_flag == 1 ){
				//PORTB |= (1<<PB3);
			} else {
				//PORTB &= ~(1<<PB3);
			}
			pin1_update = 0;
		}
        //TODO:: Please write your application code 
    }
	
	while(1){}
}