/*
 * Copyright 2010 
 *
 * The Dependable Systems Research Group
 * School of Computing
 * Clemson University
 *     
 *  author: Jason O. Hallstrom
 * version: 1.0.0
 *   since: 4/2/10
*/


#include <avr/io.h>
#include <string.h>
#include "uart.h"
#include "delay.h"


// the current UART configuration
static uart_config_t uart_config;

// indicates whether a byte was transmitted since the 
// UART was last awakened; this variable is used to 
// guard against deadlock when waiting on the transmit 
// complete flag in the uart_sleep() function
static bool byte_transmitted = false;


// used to initialize the UART
// note: see constraints on uart_config_t
void uart_init(uart_config_t* config) {

	// store the new configuration
	uart_config = *config;	
	
	// the UBRR and U2X0 settings are optimized based on 
	// calculations for a 10Mhz oscillator
	// (see pages 167 and 187-190 in the Atmega644 preliminary)
	switch(config->baud_rate) {
		case 1200:
			UART_SET_DOUBLE_SPEED();
			UART_SET_UBRR(1041);
			break;
		case 2400:
			UART_SET_DOUBLE_SPEED();
			UART_SET_UBRR(520);
			break;
		case 4800:
			UART_SET_SINGLE_SPEED();
			UART_SET_UBRR(129);
			break;
		case 9600:
			UART_SET_SINGLE_SPEED();
			UART_SET_UBRR(64);
			break;
		case 14400:
			UART_SET_DOUBLE_SPEED();
			UART_SET_UBRR(86);
			break;
		case 19200:
			UART_SET_DOUBLE_SPEED();
			UART_SET_UBRR(64);
			break;
		case 28800:
			UART_SET_DOUBLE_SPEED();
			UART_SET_UBRR(42);
			break;
		case 38400:
			UART_SET_DOUBLE_SPEED();
			UART_SET_UBRR(32);
			break;
		case 57600:
			UART_SET_DOUBLE_SPEED();
			UART_SET_UBRR(21);
			break;
		case 76800:
			UART_SET_SINGLE_SPEED();
			UART_SET_UBRR(7);
			break;
		case 115200:
			UART_SET_DOUBLE_SPEED();
			UART_SET_UBRR(10);
	}
	
	// set the parity
	// (see pages 184-185 in the Atmega644 preliminary)
	UCSR0C &= ~((1 << UPM01) | (1 << UPM00));
	switch(config->parity) {
		case NONE:
			break;
		case EVEN:
			UCSR0C |= (1 << UPM01);
			break;
		case ODD:
			UCSR0C |= ((1 << UPM01) | (1 << UPM00));
			break;
	}

	// set the number of data bits
	// (see pages 184-185 in the Atmega644 preliminary)
	UCSR0B &= ~(1 << UCSZ02); 
	UCSR0C &= ~((1 << UCSZ01) | (1 << UCSZ00));
	switch(config->data_bits) {
		case 5: 
			break;
		case 6:
			UCSR0C |= (1 << UCSZ00);
			break;
		case 7:
			UCSR0C |= (1 << UCSZ01);
			break;
		case 8:
			UCSR0C |= (1 << UCSZ01);
			UCSR0C |= (1 << UCSZ00);
			break;
		case 9:
			UCSR0B |= (1 << UCSZ02);
			UCSR0C |= (1 << UCSZ01);
			UCSR0C |= (1 << UCSZ00);
			break;
	}

	// set the number of stop bits
	// (see pages 184-185 in the Atmega644 preliminary)
	switch(config->stop_bits) {
		case 1:
			UCSR0C &= ~(1 << USBS0);
			break;
		case 2:
			UCSR0C |= (1 << USBS0);
			break;
	}

	// enable send and receive functionality
	// (overrides DDR settings)
	// (see page 197 in the Atmega644 preliminary)
	UCSR0B |= ((1 << TXEN0) | (1 << RXEN0));

	// note: when the library is updated to include support for
	// asynchronous transmission and reception (with completion
	// signals), the send and receive interrupts will need to
	// be enabled; see page 197 of the Atmega644 preliminary
}

// used to wake the UART from power reduction mode; the
// UART will be re-initialized based on the configuration 
// data passed to the last call to uart_init()
// requires: UART initialized
//
// note: post-wakeup UART behavior is peculiar:
//       i.) transmission requests are immediately successful
//           post-wakeup
//      ii.) reception requests are immediately successful
//           following a transmission request post-wakeup
//     iii.) without a transmission request, a small number
//           of reception failures may occur, post-wakeup, 
//           before the UART behavior stabilizes; the cause 
//           of this issue is unknown
void uart_wake() {
	// clear the UART bit in the power-reduction register
	// (see page 44 in the Atmega644 preliminary)
	PRR &= ~(1 << PRUSART0);

	// re-initialize the UART
	uart_init(&uart_config);
	
	// flush any garbage sitting in the RX buffer
	uart_flush_rx(UART_MAX_FLUSH_BYTES, UART_FLUSH_TIMEOUT);
	
	// the transmit complete flag is not scheduled to be set
	byte_transmitted = false;
}

// used to put the UART into power reduction mode
void uart_sleep() {	
	// wait for the pending transmission (if any) to complete
	if(byte_transmitted) {
		while (!(UCSR0A & (1 << TXC0)));
	}

	// disable the UART prior to shutting it down and 
	// put the pin in a high impedance state; this 
	// prevents unintentional current sink to any 
	// attached device
	UCSR0B &= ~((1 << TXEN0) | (1 << RXEN0));
	DDRD &= ~(1 << 1);

	// set the UART bit in the power-reduction register
	// (see page 44 in the Atmega644 preliminary)
	PRR |= (1 << PRUSART0);

	// the transmit complete flag is not scheduled to be set
	byte_transmitted = false;
}

// used to send a single byte through the UART
// requires: UART is initialized and awake
void uart_send_byte(uint8_t data) {
	// wait for the transmit buffer to be empty 
	while (!(UCSR0A & (1 << UDRE0)));
	
	// clear the transmit complete flag; 
	// copy data to the transmit buffer
	UCSR0A |= (1 << TXC0);
	UDR0 = data;

	// the transmit complete flag is scheduled to be set
	byte_transmitted = true;
}

// used to send count data bytes through the UART
// requires: UART is initialized and awake
void uart_send_bytes(uint8_t* data, uint8_t count) {
	// transmit each byte of data
	uint8_t index = 0;
	while(index < count) {
		uart_send_byte(data[index]);
		index++;
	}
}

// used to send a null-terminated character string 
// through the UART
// requires: UART is initialized and awake, strlen(string) <= 255
void uart_send_string(char* string) {
	uart_send_bytes((uint8_t*) string, strlen(string));
}

// used to receive a byte from the UART; the return value 
// indicates whether a byte was (true) or was not (false) 
// available; the call terminates when a byte is received 
// or max_wait_ms milliseconds have elapsed without receiving 
// a byte
// requires: UART is initialized and awake
bool uart_receive_byte(uint8_t* data, uint16_t max_wait_ms) {
	
	// the timeout behavior works as follows: when data
	// is unavailable, each iteration of the loop requires
	// .9us to execute; 1ms elapses every 833 iterations
	// (1000 / .9us = 1111)
	uint16_t empty_reads = 0; 
	uint16_t wait_ms = 0;
	while(wait_ms < max_wait_ms) {

		// read a byte from the UART, if available
		// (see page 196 of the Atmega644 preliminary)
		if(UCSR0A & (1 << RXC0)) {
    		*data = UDR0;
			return(true);
		} else {
			empty_reads++;
			if(empty_reads == 1111) {
				wait_ms++;
				empty_reads = 0;
			}
		}
	}
	return(false);
}

// used to receive up to capacity bytes from the UART; the 
// call terminates when the capacity is reached or max_wait_ms
// milliseconds have elapsed without receiving a new byte;
// return value indicates total bytes received
// requires: UART is initialized and awake
uint8_t uart_receive_bytes(uint8_t* data, uint8_t capacity, uint16_t max_wait_ms) {
	
	// read up to capacity bytes of data from the UART 
	uint8_t byte_count = 0;	
	bool empty_read = false;
	while((byte_count < capacity) && !empty_read) {
		if(uart_receive_byte(&(data[byte_count]), max_wait_ms)) {
			byte_count++;
		} else {
			empty_read = true;
		}
	}
	return(byte_count);
}

// used to receive up to capacity bytes from the UART; the 
// call terminates when (i) the capacity is reached or (ii) 
// max_wait_ms_start milliseconds have elapsed without receiving 
// the first byte or (iii) max_wait_ms_inter milliseconds 
// have elapsed, after the first byte was received, without 
// receiving a new byte; return value indicates total bytes 
// received
// requires: UART is initialized and awake, 
//           sizeof(data) >= capacity
uint8_t uart_receive_block(uint8_t* data, uint8_t capacity, uint16_t max_wait_ms_start, uint16_t max_wait_ms_inter) {

	if((capacity > 0) && uart_receive_byte(&data[0], max_wait_ms_start)) {
		return(uart_receive_bytes(&data[1], capacity-1, max_wait_ms_inter) + 1);
	}
	return(0);
}

// used to match a null-terminated token string against 
// a UART data stream; the call terminates when
// (i) the token is matched or (ii) (max_unmatched_bytes + 1) 
// bytes are read and unmatched or (iii) max_wait_ms_start 
// milliseconds have elapsed without receiving the first 
// byte or (iv) max_wait_ms_inter milliseconds have elapsed, 
// after the first byte was received, without receiving a 
// new byte; return value indicates success of match
// requires: UART is initialized and awake, token is 
//           null-terminated, strlen(token) < 256
bool uart_match_token(char* token, uint16_t max_unmatched_bytes, uint16_t max_wait_ms_start, uint16_t max_wait_ms_inter) {

	uint8_t match_index = 0;
	uint16_t unmatched_bytes = 0;
	uint8_t current_byte = 0;		
	bool byte_read;
	// note: current_byte is initialized to prevent a 
	//       compiler warning; the value is ignored
		
	// if the token is empty, it is matched by anything
	if(token[0] == '\x0') { 
		return(true);
	}

	// attempt to match the token one byte at a time; 
	// the match index is reset each time a mismatch
	// is encountered
	byte_read = uart_receive_byte(&current_byte, max_wait_ms_start);	
	while(byte_read && (token[match_index] != '\x0') && 
	     (unmatched_bytes <= max_unmatched_bytes)) {
		
		if(token[match_index] == current_byte) {
			match_index++;
		} else {

			// any pending match has now been broken
			unmatched_bytes += match_index;
			match_index = 0;
			
			// if the character that broke the match starts
			// a new match, increment the match index; otherwise,
			// it is another unmatched byte
			if(token[match_index] == current_byte) {
				match_index++;
			} else {
				unmatched_bytes++;
			}
		}
		
		if((token[match_index] != '\x0') && 
		   (unmatched_bytes <= max_unmatched_bytes)) {
			byte_read = uart_receive_byte(&current_byte, max_wait_ms_inter);
		}
	}
	
	return(token[match_index] == '\x0');
}

// used to match a null-terminated token string against
// a UART data stream, storing the (null-terminated) string
// prior to the token match; up to capacity-1 bytes will be
// stored; the call terminates when (i) the token is
// matched or (ii) (max_unmatched_bytes + 1) bytes are read
// and unmatched or (iii) max_wait_ms_start milliseconds have
// elapsed without receiving the first byte or
// (iv) max_wait_ms_inter milliseconds have elapsed, after
// the first byte was received, without receiving a new byte;
// return value indicates success of match
// requires: UART is initialized and awake,
//		     sizeof(buffer) >= capacity, token is
//           null-terminated, strlen(token) < 256
bool uart_store_before_match_token(char* buffer, uint16_t capacity, char* token, uint16_t max_unmatched_bytes, uint16_t max_wait_ms_start, uint16_t max_wait_ms_inter) {
	
	uint8_t match_index = 0;
	uint16_t unmatched_bytes = 0;
	uint8_t current_byte = 0;
	uint8_t buffer_index = 0;
	bool byte_read;
	// note: current_byte is initialized to prevent a
	//       compiler warning; the value is ignored
	
	// if the token is empty, it is matched by anything
	if(token[0] == '\x0') {
		buffer[0] = '\x0';
		return(true);
	}

	// attempt to match the token one byte at a time;
	// the match index is reset each time a mismatch
	// is encountered; store bytes received prior to 
	// the match
	byte_read = uart_receive_byte(&current_byte, max_wait_ms_start);
	while(byte_read && (token[match_index] != '\x0') &&
		 (unmatched_bytes <= max_unmatched_bytes)) {
		
		if(token[match_index] == current_byte) {
			match_index++;
		} else {
			
			// if a token match was interrupted, the previously matched 
			// bytes must be appended to the storage buffer
			if(match_index > 0) {
				uint16_t bytes_to_copy = (buffer_index + match_index < capacity) ? (match_index) : (capacity - buffer_index - 1);
				memcpy(&buffer[buffer_index], token, bytes_to_copy);
				buffer_index += bytes_to_copy;	
			
				unmatched_bytes += match_index;
				match_index = 0;
			}
			
			// if the character that broke the match starts
			// a new match, increment the match index; otherwise,
			// it is another unmatched byte
			if(token[match_index] == current_byte) {
				match_index++;
			} else {
				unmatched_bytes++;
				if(buffer_index < capacity-1) {
					buffer[buffer_index++] = current_byte;
				}
			}
		}
		
		if((token[match_index] != '\x0') &&
		   (unmatched_bytes <= max_unmatched_bytes)) {
			byte_read = uart_receive_byte(&current_byte, max_wait_ms_inter);
		}
	}
	
	// null-terminate the pre-token data
	if(token[match_index] == '\x0') {
		buffer[buffer_index] = '\x0';
		return(true);
	} else {
		buffer[0] = '\x0';
		return(false);
	}
}

// used to flush the RX buffer; up to max_flush_bytes bytes 
// of data will be discarded; the call will terminate if 
// max_flush_ms milliseconds elapse without receiving any data
// requires: UART is initialized and awake
void uart_flush_rx(uint16_t max_flush_bytes, uint16_t max_flush_ms) {
	
	// flush the RX buffer
	bool byte_read = true;
	uint8_t garbage;
	uint16_t byte_count = 0;
	while((byte_read) && (byte_count < max_flush_bytes)) { 
		byte_read = uart_receive_byte(&garbage, max_flush_ms);
		byte_count++;
	}
}

