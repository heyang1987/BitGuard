/*
 * test_rfm12.c
 *
 * Created: 2/20/2013 12:58:22 AM
 *  Author: jonas
 */ 


#include <avr/io.h>
#include<stdlib.h>
#include <stdio.h>
#define F_CPU 8000000UL
#include <util/delay.h>
#include <stdbool.h>
#include <string.h>
#include <avr/interrupt.h>
#include "rfm12.h"
//#include "usart.h"
#include "uart.h"
#include "bufferFunc.h"

uint8_t data[64];
Buffer data_local;
	
int main2(void)
{
	data_local.buffer = data;
	data_local.count = 0;
	//usart_init();
	uart_config_t uart_config = (uart_config_t){ 9600, NONE, 8, 1 };
	uart_init(&uart_config);
	uart_send_string(">>>>>>>>>>>>UART Ready.\r\n");
	
	init_rfm12();
	init_receive();
	
	/*
	EIMSK = 1;
	DDRD &= ~(1<<2);
	PORTD |= (1<<2);
	EICRA = 0;
	*/
	// PCINT0: Radio interrupt
	DDRB &= ~(1<<0);
	PORTB |= (1<<0);
	PCICR |= (1<<PCIE0);
	PCMSK0 |= (1<<PCINT0);
	sei();
	
	//_delay_ms(1000);
	//frame.address_source = Rx_source_add;
	while(1){
	}
}	


ISR(PCINT0_vect){
	if( !(PINB & _BV(PB0)) ){
		uint8_t destination__address,source__address;
		//if (received__data(&data_local,&source__address,&destination__address)){
		if (receive(&data_local, NULL, NULL, &source__address,&destination__address)){
			uart_send_bytes(data_local.buffer, data_local.count - 1);
			sprintf(data, "Received...\r\n", "");
			data_local.count = 13;
			transmit(&data_local, 'D', 255);
		} else {
			uart_send_string("YY");
		}
	}
}

/*
ISR(INT0_vect)
{

	uint8_t destination__address,source__address;
	if (received__data(&data_local,&source__address,&destination__address)){
		uart_send_bytes(data_local.buffer, data_local.count - 1);
	}	
}
*/
