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


#ifndef UART_H
#define UART_H


#include <stdint.h>
#include <stdbool.h>


//--- 
// library configuration constants
//---
// upon wakeup, the UART may contain garbage data; up to 
// UART_MAX_FLUSH_BYTES will be discarded upon wakeup
//
// note: the UART should always be awoken *after* any 
//       UART-attached peripheral
#define UART_MAX_FLUSH_BYTES				((uint16_t) 10)

// the maximum number of milliseconds to wait for a byte 
// of garbage data during a wakeup flush
#define UART_FLUSH_TIMEOUT					((uint16_t) 1)
//---


//---
// UART speed setting macros
// used to put the UART in single-speed mode
#define UART_SET_SINGLE_SPEED() \
	UCSR0A &= ~(1 << U2X0)

// used to put the UART in double-speed mode
#define UART_SET_DOUBLE_SPEED() \
	UCSR0A |= (1 << U2X0)
	
// used to set the UBRR value
// (UBRR and speed mode determine baud rate)
#define UART_SET_UBRR(value) \
	UBRR0H = value >> 8; \
	UBRR0L = value & 0xff
//---


// used to specify a UART parity setting
typedef enum {
	NONE,
	EVEN,
	ODD
} parity_t;

// used to specify a UART configuration
// constraints:
//    baud_rate in { 1200, 2400, 4800, 9600, 14400, 19200, 28800, 38400, 57600, 76800, 115200 }
//    data_bits in { 5, 6, 7, 8 }
//    stop_bits in { 1, 2 } 
typedef struct {
	uint32_t baud_rate;
	parity_t parity;
	uint8_t  data_bits;
	uint8_t  stop_bits; 
} uart_config_t;


// used to initialize the UART
// note: see constraints on uart_config_t
void uart_init(uart_config_t* config);

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
//           of reception failures may occur, post-wakup, 
//           before the UART behavior stabilizes; the cause 
//           of this issue is unknown
void uart_wake();

// used to put the UART into power reduction mode
void uart_sleep();

// used to send a single byte through the UART
// requires: UART is initialized and awake
void uart_send_byte(uint8_t data);

// used to send count bytes through the UART
// requires: UART is initialized and awake
void uart_send_bytes(uint8_t* data, uint8_t count);

// used to send a null-terminated character string 
// through the UART
// requires: UART is initialized and awake, strlen(string) <= 255
void uart_send_string(char* string);

// used to receive a byte from the UART; the return value 
// indicates whether a byte was (true) or was not (false) 
// available; the call terminates when a byte is received 
// or max_wait_ms milliseconds have elapsed without receiving 
// a byte
// requires: UART is initialized and awake
bool uart_receive_byte(uint8_t* data, uint16_t max_wait_ms);

// used to receive up to capacity bytes from the UART; the 
// call terminates when the capacity is reached or max_wait_ms
// milliseconds have elapsed without receiving a new byte;
// return value indicates total bytes received
// requires: UART is initialized and awake
uint8_t uart_receive_bytes(uint8_t* data, uint8_t capacity, uint16_t max_wait_ms);

// used to receive up to capacity bytes from the UART; the 
// call terminates when (i) the capacity is reached or (ii) 
// max_wait_ms_start milliseconds have elapsed without receiving 
// the first byte or (iii) max_wait_ms_inter milliseconds 
// have elapsed, after the first byte was received, without 
// receiving a new byte; return value indicates total bytes 
// received
// requires: UART is initialized and awake, 
//           sizeof(data) >= capacity
uint8_t uart_receive_block(uint8_t* data, uint8_t capacity, uint16_t max_wait_ms_start, uint16_t max_wait_ms_inter);

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
bool uart_match_token(uint8_t* token, uint16_t max_unmatched_bytes, uint16_t max_wait_ms_start, uint16_t max_wait_ms_inter);

// used to flush the RX buffer; up to max_flush_bytes bytes 
// of data will be discarded; the call will terminate if 
// max_flush_ms milliseconds elapse without receiving any data
// requires: UART is initialized and awake
void uart_flush_rx(uint16_t max_flush_bytes, uint16_t max_flush_ms);

// Used to match a null-terminated token string against
// A UART data stream; store the string that from the beginning 
// of the stream to the matched token.
// the call terminates when
// (i) the token is matched or (ii) (max_unmatched_bytes + 1) 
// bytes are read and unmatched or (iii) max_wait_ms_start 
// milliseconds have elapsed without receiving the first 
// byte or (iv) max_wait_ms_inter milliseconds have elapsed, 
// after the first byte was received, without receiving a 
// new byte; return value indicates success of match
// requires: UART is initialized and awake, token is 
//           null-terminated, strlen(token) < 256
bool uart_receive_match_token(uint8_t* data, uint16_t capacity, uint8_t* token, uint16_t max_unmatched_bytes, uint16_t max_wait_ms_start, uint16_t max_wait_ms_inter);


#endif

