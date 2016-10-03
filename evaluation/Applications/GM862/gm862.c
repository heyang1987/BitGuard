/*
 * The Dependable Systems Research Group
 * School of Computing
 * Clemson University
 *
 * Author: Jiannan Zhai, Jason O. Hallstrom
 * Version: 1.0.0
 */ 


#include <string.h>
#include <stdlib.h>
#include <ctype.h>
#include "gm862.h"
#include "diagnostics.h"


// used to initialize the gm862
// note: see constraints on uart_config_t
void gm862_init(uart_config_t* uart_config) {	
	
	uart_init(uart_config);
	GM_POWER_CONTROL_DDR = (1 << GM_POWER_CONTROL_PIN);
	GM_ON_OFF_DDR = (1 << GM_ON_OFF_PIN);
	GM_POWER_CONTROL_PORT &= ~(1 << GM_POWER_CONTROL_PIN);
	GM_ON_OFF_PORT &= ~(1 << GM_ON_OFF_PIN);
}

// used to wake the gm862; return value indicates 
// presence of modem in ready state
// requires: gm862 is initialized and asleep
bool gm862_wake() {
	
	GM_POWER_UP();
	uart_wake();
	GM_ON();
	
	// probe the device 
	gm862_send_command(GM_CMD_PROBE);
	bool result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_PROBE_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_wake_errors++;		
	}
	//---
	
	return(result);
}

// used to put the gm862 to sleep
// requires: gm862 is initialized and in command mode
void gm862_sleep() {
	
	// attempt to shutdown the gm862 via command
	// note: this is somewhat inefficient; it would be best to just cut power,
	//       but this would not give the device a chance to disconnect from 
	//       the cellular network; it would be bad practice
	gm862_send_command(GM_CMD_SHUTDOWN);
	bool result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_SHUTDOWN_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_sleep_errors++;
	}
	//---
	
	uart_sleep();
	GM_POWER_DOWN();
	delay_ms(GM_POWER_DOWN_DELAY);
}

// used to configure the default profile used by the gm862;
// intended to be invoked once per session; return value
// indicates success; on failure, device may be shutdown;
// email_config may be null
// requires: gm862 is initialized and in command mode
bool gm862_set_default_profile(email_config_t* email_config) {
	
	// set the command style to the new AT interface
	gm862_send_command(GM_CMD_SET_NEW_INTERFACE);
	bool result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_SET_NEW_INTERFACE_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	if(result) {
		// after the new AT command interface is selected, the
		// device requires this delay before accepting certain
		// commands (including AT+CGDCONT, AT#NITZ, and others)
		delay_ms(GM_POST_SELINT_DELAY);
	}		
	
	if(result) {
		// turn off command echo
		gm862_send_command(GM_CMD_NOECHO);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_NOECHO_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}		
	
	if(result) {
		// set the gsm frequency band
		gm862_send_command(GM_SET_BAND_P1);
		uart_send_string(GM_BAND);
		uart_send_string(GM_SET_BAND_P2);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SET_BAND_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}		
	
	if(result) {
		// set the gprs context parameters
		gm862_send_command(GM_CONFIGURE_CONTEXT_P1);
		uart_send_string(GM_APN_NAME);
		uart_send_string(GM_CONFIGURE_CONTEXT_P2);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CONFIGURE_CONTEXT_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	if(result) {
		// set the IP connection parameters
		gm862_send_command(GM_CONFIGURE_CONNECTION_P1);
		uart_send_string(GM_IP_MAX_PACKET_SIZE);
		uart_send_byte(',');
		uart_send_string(GM_IP_INACTIVITY_TIMEOUT);
		uart_send_byte(',');
		uart_send_string(GM_IP_CONNECTION_TIMEOUT);
		uart_send_byte(',');
		uart_send_string(GM_IP_SEND_DELAY);
		uart_send_string(GM_CONFIGURE_CONNECTION_P2);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CONFIGURE_CONNECTION_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	if(result) {
		// set the modem to synchronize its internal clock with network time at boot
		gm862_send_command(GM_CMD_SET_TIME_SYNCH);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_SET_TIME_SYNCH_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	if(result) {
		// set the sms input mode to text (not pdu)
		gm862_send_command(GM_SET_SMS_TEXT_MODE);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SET_SMS_TEXT_MODE_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	if(result) { 
		// set the smtp server address
		gm862_send_command(GM_SET_SMTP_SERVER_P1);
		uart_send_string(email_config->smtp_address);
		uart_send_string(GM_SET_SMTP_SERVER_P2);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SET_SMTP_SERVER_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	if(result) {
		// set the smtp user name
		gm862_send_command(GM_SET_SMTP_USER_P1);
		uart_send_string(email_config->user_name);
		uart_send_string(GM_SET_SMTP_USER_P2);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SET_SMTP_USER_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	if(result) {
		// set the smtp password
		gm862_send_command(GM_SET_SENDER_ADDRESS_P1);
		uart_send_string(email_config->sender_address);
		uart_send_string(GM_SET_SENDER_ADDRESS_P2);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SET_SENDER_ADDRESS_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	if(result) {
		// set the modem to load the stored profile at startup
		gm862_send_command(GM_CMD_SET_LOAD_PROFILE);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_SET_LOAD_PROFILE_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	if(result) {
		// store the complete profile
		gm862_send_command(GM_CMD_STORE_PROFILE);
		result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_STORE_PROFILE_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	}
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_set_profile_errors++;
	}
	//---
	
	// shutdown and reboot the gm862
	if(result) {
		gm862_sleep();
		return(gm862_wake());
	} 
	
	return(false);
}

// used to check whether the gm862 is gsm registered;
// return value indicates registration status
// requires: gm862 is initialized and in command mode
bool gm862_gsm_registered() {
		
	// request the registration status
	gm862_send_command(GM_CMD_GSM_STATUS);
	char raw_response[20];
	bool result = uart_store_before_match_token(raw_response, sizeof(raw_response), GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_GSM_STATUS_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	// if a valid response was received, determine if the gm862 is registered
	if(result) {
		result = (strstr(raw_response, GM_GSM_RESPONSE) != NULL);
	}
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_gsm_registration_errors++;
	}
	//---
	
	return(result);	
}

// used to check whether the gm862 is gprs registered;
// return value indicates registration status
// requires: gm862 is initialized and in command mode
bool gm862_gprs_registered() {
	
	// request the registration status
	gm862_send_command(GM_CMD_GPRS_STATUS);
	char raw_response[20];
	bool result = uart_store_before_match_token(raw_response, sizeof(raw_response), GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_GPRS_STATUS_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	// if a valid response was received, determine if the gm862 is registered
	if(result) {
		result = (strstr(raw_response, GM_GPRS_RESPONSE) != NULL);
	}
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_gprs_registration_errors++;
	}
	//---
	
	return(result);
}

// used to check the cellular signal; return value
// indicates strength (0-31; 99 reflects no signal)
// requires: gm862 is initialized, gsm registered,
// and in command mode
uint8_t gm862_rssi() {
	
	// request the signal strength
	gm862_send_command(GM_CMD_CHECK_RSSI);
	char raw_response[20];
	bool result = uart_store_before_match_token(raw_response, sizeof(raw_response), GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_CHECK_RSSI_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);

	// if a valid response was received, parse out the RSSI 
	// value and convert to a uint8_t
	if(result) {
		// response format: "...+CSQ: xx..." (with leading and/or trailing bytes)
		char* response = strstr(raw_response, "+CSQ: ");
		if((response != NULL) && (strlen(response) >= 7) && isdigit(response[6])) {
			return((uint8_t) atoi(&response[6]));
		}			
	}
	
	//---
	// diagnostic reporting
	gm862_diagnostics.gm862_rssi_errors++;
	//---
	
	// invalid response; treat as no signal
	return(99);
}

// used to retrieve the current date and time;
// (note: the internal clock is synchronized with network time
//        at boot, but the synchronization is not instantaneous)
// requires: gm862 is initialized, gsm registered, and in
//           command mode
datetime_t gm862_current_time() {
	
	datetime_t ret_value = { 0 };
		
	// request the current time
	gm862_send_command(GM_CMD_NETWORK_TIME);
	char raw_response[35];
	bool result = uart_store_before_match_token(raw_response, sizeof(raw_response), GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_CMD_NETWORK_TIME_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	if(result) {
		// if a valid response was received, parse out the date 
		// and time information
		// response format: "...+CCLK: "yy/mm/dd,hh:mm:ss"..." (with leading and/or trailing bytes)
		char* response = strstr(raw_response, "+CCLK: \"");
		if((response != NULL) && (strlen(response) >= 26) && (response[7] == '"') && (response[25] == '"')) {
			ret_value.year = atoi(&response[8]);
			ret_value.month = atoi(&response[11]);
			ret_value.day = atoi(&response[14]);
			ret_value.hours = atoi(&response[17]);
			ret_value.minutes = atoi(&response[20]);
			ret_value.seconds = atoi(&response[23]);
		} else {
			result = false;
		}
	}
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_time_errors++;
	}		
	//---
	
	return(ret_value);
}

// used to initiate an sms message to a null-terminated
// phone number; return value indicates result; successful
// call must be followed by transmission of the message
// data and a call to gm862_end_sms()
// requires: strlen(number) = 10; gm862 is initialized, gsm
//			 registered, and in command mode;
//			 [strlen(<message data>) <= 160]
bool gm862_start_sms(char* number) {
	
	// initiate SMS text entry
	gm862_send_command(GM_SET_SMS_TEXT_P1);
	uart_send_string(number);
	uart_send_string(GM_SET_SMS_TEXT_P2);
	bool result = uart_match_token(GM_PROMPT_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SET_SMS_TEXT_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	if(result) {
		delay_ms(GM_PRE_CMD_DELAY);
	} 
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_sms_start_errors++;
	}
	//---
	
	return(result);
}

// used to trigger transmission of an in-progress sms
// message; return value indicates result
// requires: gm862 is initialized, gsm registered, and
//           in sms mode;
//			 [strlen(<message data>) <= 160]
bool gm862_end_sms() {
	
	// trigger transmission of the message
	gm862_send_command(GM_SEND_SMS);
	bool result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SEND_SMS_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_sms_end_errors++;
	}
	//---
	
	return(result);
}

// used to send a null-terminated SMS message to a
// null-terminated phone number; return value indicates
// transmission result
// requires: strlen(number) = 10; strlen(message) <= 160;
//           gm862 is initialized, gsm registered, and in
//           command mode
bool gm862_send_sms(char* number, char* message) {
	
	// initiate message
	bool result = false;
	if(gm862_start_sms(number)) {
	
		// transmit the SMS text	
		uart_send_string(message);		
		
		// trigger transmission of the message
		result = gm862_end_sms();
	}
	return(result);
}

// used to connect to the internet; return value is the
// acquired IP address, or 0x00000000 if unsuccessful
// requires: gm862 is initialized, gsm registered, gprs
//           registered, not connected to the internet,
//           and in command mode
uint32_t gm862_acquire_ip() {
	
	// activate the first context
	gm862_send_command(GM_ACTIVATE_CONTEXT);
	char raw_response[30];
	bool result = uart_store_before_match_token(raw_response, sizeof(raw_response), GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_ACTIVATE_CONTEXT_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);

	// if a valid response was received, parse out the IP address 
	// and convert to a uint32_t
	if(result) {
		// response format: "...#SGACT: #.#.#.#..." (with leading and/or trailing bytes)
		char* response = strstr(raw_response, "#SGACT: ");
		if((response != NULL) && (strlen(response) >= 15) && (isdigit(response[8]))) {
			// parse byte 4
			uint32_t address;
			char* number = &response[8];
			address = ((uint32_t) atoi(number) << 24);
			
			// parse byte 3
			number = strstr(&number[1], ".");
			if((number != NULL) && (strlen(number) >= 6) && isdigit(number[1])) {
				address |= ((uint32_t) atoi(&number[1]) << 16);
			} else {
				// invalid response; address not acquired
				result = false;
			}				
				
			if(result) {
				// parse byte 2
				number = strstr(&number[1], ".");
				if((number != NULL) && (strlen(number) >= 4) && isdigit(number[1])) {
					address |= ((uint32_t) atoi(&number[1]) << 8);
				} else {
					// invalid response; address not acquired
					result = false;
				}
			}				
			
			if(result) {
				// parse byte 1
				number = strstr(&number[1], ".");
				if((number != NULL) && (strlen(number) >= 2) && isdigit(number[1])) {
					address |= ((uint32_t) atoi(&number[1]));
				} else {
					// invalid response; address not acquired
					result = false;
				}					
			}
			
			// address parsed successfully
			if(result) {
				return(address);		
			}
		}			
	}
		
	//---
	// diagnostic reporting
	gm862_diagnostics.gm862_get_ip_errors++;
	//---
	
	// invalid response; address not acquired
	return(0x00000000);
}

// used to disconnect from the internet; return value
// indicates success
// requires: gm862 is initialized, gsm registered,
//           gprs registered, connected to the internet,
//           and in command mode
bool gm862_drop_ip() {

	// deactivate the first context
	gm862_send_command(GM_DEACTIVATE_CONTEXT);
	bool result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_DEACTIVATE_CONTEXT_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_drop_ip_errors++;
	}		
	//---
	
	return(result);
}

// used to initiate an email to a null-terminated address
// with a null-terminated subject; return value indicates
// result; successful call must be followed by transmission
// of the body data and a call to gm862_end_email()
// requires: gm862 is initialized, gsm registered,
//           gprs registered, connected to the internet,
//           and in command mode
bool gm862_start_email(char* dest_address, char* subject) {
	
	// initiate email text entry
	gm862_send_command(GM_SET_EMAIL_TEXT_P1);
	uart_send_string(dest_address);
	uart_send_string("\",\"");
	uart_send_string(subject);
	uart_send_string(GM_SET_EMAIL_TEXT_P2);
	bool result = uart_match_token(GM_PROMPT_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SET_EMAIL_TEXT_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	if(result) {
		delay_ms(GM_PRE_CMD_DELAY);
	}
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_email_start_errors++;
	}
	//---
	
	return(result);
}

// used to trigger transmission of an in-progress email;
// return value indicates result
// requires: gm862 is initialized, gsm registered,
//           gprs registered, connected to the internet,
//           and in email mode
bool gm862_end_email() {
	
	// trigger transmission of the email
	gm862_send_command(GM_SEND_EMAIL);
	bool result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_SEND_EMAIL_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_email_end_errors++;
	}
	//---
	
	return(result);
}

// used to send an email to a null-terminated address,
// with a specified null-terminated subject and body;
// return value indicates result
// requires: gm862 is initialized, gsm registered,
//           gprs registered, connected to the internet,
//           and in command mode
bool gm862_send_email(char* dest_address, char* subject, char* body) {
	
	// initiate email
	bool result = false;
	if(gm862_start_email(dest_address, subject)) {
		
		// transmit the email text
		uart_send_string(body);
		
		// trigger transmission of the email
		result = gm862_end_email();
	}
	
	return(result);
}

// used to establish a tcp connection to a specified address
// and port; return value indicates success; if successful,
// the device will be in data mode; if unsuccessful, the mode
// is unspecified
// requires: gm862 is initialized, gsm registered, gprs registered,
//			 connected to the internet, and in command mode
bool gm862_tcp_connect(char* address, uint16_t port) {
	
	// convert port to string
	char port_string[6];
	itoa(port, port_string, 10);
	
	// establish connection
	gm862_send_command(GM_TCP_CONNECT_P1);
	uart_send_string(port_string);
	uart_send_string(",\"");
	uart_send_string(address);
	uart_send_string(GM_TCP_CONNECT_P2);
	bool result = uart_match_token(GM_CONNECT_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_TCP_CONNECT_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_tcp_connect_errors++;
	}
	//---
	
	return(result);
}

// used to disconnect a tcp connection; return value
// indicates success
// requires: gm862 is initialized and in command mode
bool gm862_tcp_disconnect() {
	
	// disconnect the socket
	gm862_send_command(GM_TCP_DISCONNECT);
	bool result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_TCP_DISCONNECT_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_tcp_disconnect_errors++;
	}
	//---
	
	return(result);
}

// used to enter command mode; return value indicates success
// requires: gm862 is initialized and in data mode
bool gm862_enter_command_mode() {
	
	// enter command mode
	delay_ms(GM_ESCAPE_DELAY);
	gm862_send_command(GM_COMMAND_MODE);
	bool result = uart_match_token(GM_OK_RESPONSE, GM_MAX_BAD_RESPONSE_BYTES, GM_COMMAND_MODE_TIMEOUT, GM_INTERNAL_RECEPTION_TIMEOUT);
	
	//---
	// diagnostic reporting
	if(!result) {
		gm862_diagnostics.gm862_escape_errors++;
	}
	//---
	
	return(result);
}	

// used internally to initiate a (null-terminated) multi-string command, 
// or to send a complete command
// requires: gm862 is initialized and in command mode
void gm862_send_command(char* command) {
	// introduce the require inter-command delay;
	// flush the receive buffer;
	// issue the command
	delay_ms(GM_PRE_CMD_DELAY);
	uart_flush_rx(GM_MAX_BAD_RESPONSE_BYTES, GM_INTERNAL_RECEPTION_TIMEOUT);
	uart_send_string(command);
}	


//---
// data transmission functions
// (note: in current implementation, calls are delegated to
//        uart_xxx() functions)
//---


// used to send a single byte through the gm862
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
void gm862_send_byte(uint8_t data) {
	uart_send_byte(data);
}

// used to send count bytes through the gm862
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
void gm862_send_bytes(uint8_t* data, uint8_t count) {
	uart_send_bytes(data, count);
}

// used to send a null-terminated character string
// through the gm862
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
void gm862_send_string(char* string) {
	uart_send_string(string);
}

// used to receive a byte from the gm862; the return value
// indicates whether a byte was (true) or was not (false)
// available; the call terminates when a byte is received
// or max_wait_ms milliseconds have elapsed without receiving
// a byte
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
bool gm862_receive_byte(uint8_t* data, uint16_t max_wait_ms) {
	return(uart_receive_byte(data, max_wait_ms));
}	

// used to receive up to capacity bytes from the gm862; the
// call terminates when the capacity is reached or max_wait_ms
// milliseconds have elapsed without receiving a new byte;
// return value indicates total bytes received
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
uint8_t gm862_receive_bytes(uint8_t* data, uint8_t capacity, uint16_t max_wait_ms) {
	return(uart_receive_bytes(data, capacity, max_wait_ms));
}


