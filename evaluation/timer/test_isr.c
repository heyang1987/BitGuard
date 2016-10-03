/* 
 * test_timer_interrupt.c 
 * 
 * Created: 4/9/2013 11:42:16 PM 
 *  Author: jonas 
 */ 
#include <avr/io.h> 
#include "uart.h" 
#include <avr/interrupt.h> 
  
//#define F_CPU 10000000L 
  
#define TTT (uint8_t)30 
volatile uint16_t pre = TTT * 10; 
volatile uint16_t counter = 0; 
  
ISR(TIMER0_OVF_vect) { 
    if( counter >= pre ){ 
        uart_send_string("A\r\n"); 
        counter = 0; 
    } else { 
        counter++; 
    } 
} 
  
int main(void){ 
    uart_config_t uart_config = (uart_config_t){ 115200, NONE, 8, 1 }; 
    uart_init(&uart_config); 
    uart_send_string("UART Ready.\r\n"); 
        // Timer0 configuration 
    TIMSK0 |= (1<<TOIE0); // Enable timer0 interrupt 
    TCNT1 = 0x00;           // Counter start from 0 
    TCCR0B |= (1<<CS00) | (1<<CS02);    // Prescaler set to 1024 
      
    sei(); 
      
    while(1){} 
}
