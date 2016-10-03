/*
 * The Dependable Systems Research Group
 * School of Computing
 * Clemson University
 *
 * Author: Jiannan Zhai, Jason O. Hallstrom
 * Version: 1.0.0
 */ 


#ifndef GM862_H
#define GM862_H


#include <avr/io.h>
#include <stdint.h>
#include <stdbool.h>
#include "delay.h"
#include "uart.h"


//---
// gm862 port bindings
//---
// board-level power control pin
#define GM_POWER_CONTROL_DDR				DDRA
#define GM_POWER_CONTROL_PORT				PORTA
#define GM_POWER_CONTROL_PIN				6

// gm862 on/off pin
#define GM_ON_OFF_DDR						DDRC
#define GM_ON_OFF_PORT						PORTC
#define GM_ON_OFF_PIN						4
//---


//---
// library configuration constants
// (note: all timing parameters are expressed in milliseconds, 
//        unless otherwise noted)
//---
// the duration the "on" button must be depressed to
// turn the gm862 on (or off), in milliseconds
#define GM_ON_OFF_PUSH_DELAY				((uint16_t) 1250)

// the time required for the modem to boot prior to 
// accepting commands, in milliseconds
#define GM_BOOT_DELAY						((uint16_t) 1750)

// after the new AT command interface is selected, the
// device requires this delay before accepting certain
// commands (including AT+CGDCONT, AT#NITZ, and others)
#define GM_POST_SELINT_DELAY				((uint16_t) 5000)

// the time required for the gm862 to safely power off
// after power is removed from the board
#define GM_POWER_DOWN_DELAY					((uint16_t) 1000)

// if commands are issued to the gm862 too quickly, they
// will be ignored; this delay is inserted prior to every
// command 
#define GM_PRE_CMD_DELAY					((uint16_t) 250)

// the delay introduced before issuing the escape sequence to
// enter command mode
#define GM_ESCAPE_DELAY						((uint16_t) 2000)

// when looking for a response token, this constant controls the
// number of unmatched token bytes that will be tolerated
// before the token search terminates
#define GM_MAX_BAD_RESPONSE_BYTES			((uint16_t) 100)

// the amount of time to wait before terminating reception after 
// the first response byte is received from the gm862 (without
// receiving subsequent bytes)
#define GM_INTERNAL_RECEPTION_TIMEOUT		((uint16_t) 20)

// the gsm frequency band of the network
// (North America = 1)
#define GM_BAND								((char*) "1")

// the access point name of the data network; provider specific
// (AT&T="broadband")
#define GM_APN_NAME							((char*) "wap.cingular")

// the maximum number of bytes that will be buffered before a
// network packet is automatically sent
#define GM_IP_MAX_PACKET_SIZE				((char*) "300")

// the network inactivity timeout, in seconds; at timeout,
// the inactive connection is closed
#define GM_IP_INACTIVITY_TIMEOUT			((char*) "30")

// the network connection timeout, in tenths-of-a-second;
// at timeout, the connection attempt will be aborted
// (note: timeout value must be consistent with GM_TCP_CONNECT_TIMEOUT)
#define GM_IP_CONNECTION_TIMEOUT			((char*) "300")

// the inactivity delay, after which buffered data will be 
// sent, in tenths-of-a-second
#define GM_IP_SEND_DELAY					((char*) "15")
//---


//---
// gm862 primitives
//---
// used to supply power to the gm862 board
#define GM_POWER_UP()		GM_POWER_CONTROL_PORT |= (1 << GM_POWER_CONTROL_PIN);

// used to cut power to the gm862 board
#define GM_POWER_DOWN()		GM_POWER_CONTROL_PORT &= ~(1 << GM_POWER_CONTROL_PIN);

// used to turn the gm862 on (assuming it's off)
#define GM_ON()\
	GM_ON_OFF_PORT |= (1 << GM_ON_OFF_PIN);\
	delay_ms(GM_ON_OFF_PUSH_DELAY);\
	GM_ON_OFF_PORT &= ~(1 << GM_ON_OFF_PIN);\
	delay_ms(GM_BOOT_DELAY)
//---


//---
// gm862 commands, response timeouts (in milliseconds)
//---
// used to probe the device (for "on" status)
#define GM_CMD_PROBE						((char*) "AT\x0d")
#define GM_CMD_PROBE_TIMEOUT				((uint16_t) 1500)

// used to turn off echoing of commands
#define GM_CMD_NOECHO						((char*) "ATE\x0d")
#define GM_CMD_NOECHO_TIMEOUT				((uint16_t) 1500)

// used to power down the gm862
#define GM_CMD_SHUTDOWN						((char*) "AT#SHDN\x0d")
#define GM_CMD_SHUTDOWN_TIMEOUT				((uint16_t) 10000)

// used to select the new AT command set
// (profile setting)
#define GM_CMD_SET_NEW_INTERFACE			((char*) "AT#SELINT=2\x0d")
#define GM_CMD_SET_NEW_INTERFACE_TIMEOUT	((uint16_t) 1500)

// used to set the gsm frequency band
// (must be followed by "<1-4>\x0d")
// (profile setting)
#define GM_SET_BAND_P1						((char*) "AT#BND=")
#define GM_SET_BAND_P2						((char*) "\x0d")
#define GM_SET_BAND_TIMEOUT					((uint16_t) 1500)

// used to set the gprs context parameters
// (part 1 must be followed by ""<apn>"", then part 2)
// (context=1, protocol=ip, apn=<apn>, address=dhcp, data compression=on, header compression=on)
// (30 second maximum documented timeout)
// (profile setting)
#define GM_CONFIGURE_CONTEXT_P1				((char*) "AT+CGDCONT=1,\"IP\",\"")
#define GM_CONFIGURE_CONTEXT_P2				((char*) "\",\"0.0.0.0\",1,1\x0d")
#define GM_CONFIGURE_CONTEXT_TIMEOUT		((uint16_t) 15000)

// used to configure the network connection parameters
// (part 1 must be followed by "<packet size>, <inactivity timeout>, <connection timeout>, <send delay>", then part 2)
// (connection id=1, context id=1, packet size=<ps>, inactivity timeout=<to1>, connection timeout=<to2>, send delay=<sd>)
// (profile setting)
#define GM_CONFIGURE_CONNECTION_P1			((char*) "AT#SCFG=1,1,")
#define GM_CONFIGURE_CONNECTION_P2			((char*) "\x0d")
#define GM_CONFIGURE_CONNECTION_TIMEOUT		((uint16_t) 1500)

// used to synchronize the internal clock to network time at startup
// (profile setting)
#define GM_CMD_SET_TIME_SYNCH				((char*) "AT#NITZ=1,0\x0d")
#define GM_CMD_SET_TIME_SYNCH_TIMEOUT		((uint16_t) 1500)

// used to set the SMS mode to text (not pdu)
// (profile setting)
#define GM_SET_SMS_TEXT_MODE				((char*) "AT+CMGF=1\x0d")
#define GM_SET_SMS_TEXT_MODE_TIMEOUT		((uint16_t) 5000)

// used to set the smtp server address
// (part 1 must be followed by "<server address>", then part 2)
// (server address=<sa>)
// (profile setting)
#define GM_SET_SMTP_SERVER_P1				((char*) "AT#ESMTP=\"")
#define GM_SET_SMTP_SERVER_P2				((char*) "\"\x0d")
#define GM_SET_SMTP_SERVER_TIMEOUT			((uint16_t) 1500)

// used to set the smtp user name
// (part 1 must be followed by "<user name>", then part 2)
// (user name=<un>)
// (profile setting)
#define GM_SET_SMTP_USER_P1					((char*) "AT#EUSER=\"")
#define GM_SET_SMTP_USER_P2					((char*) "\"\x0d")
#define GM_SET_SMTP_USER_TIMEOUT			((uint16_t) 1500)

// used to set the smtp password
// (part 1 must be followed by "<password>", then part 2)
// (password=<pw>)
// (profile setting)
#define GM_SET_SMTP_PASSWORD_P1				((char*) "AT#EPASSW=\"")
#define GM_SET_SMTP_PASSWORD_P2				((char*) "\"\x0d")
#define GM_SET_SMTP_PASSWORD_TIMEOUT		((uint16_t) 1500)

// used to set the sender address
// (part 1 must be followed by "<sender address>", then part 2)
// (sender address=<sa>)
// (profile setting)
#define GM_SET_SENDER_ADDRESS_P1			((char*) "AT#EADDR=\"")
#define GM_SET_SENDER_ADDRESS_P2			((char*) "\"\x0d")
#define GM_SET_SENDER_ADDRESS_TIMEOUT		((uint16_t) 1500)

// used to cause the profile to be loaded at startup
// (profile setting)
#define GM_CMD_SET_LOAD_PROFILE				((char*) "AT&P0\x0d")
#define GM_CMD_SET_LOAD_PROFILE_TIMEOUT		((uint16_t) 1500)

// used to store the complete profile
#define GM_CMD_STORE_PROFILE				((char*) "AT&W0\x0d")
#define GM_CMD_STORE_PROFILE_TIMEOUT		((uint16_t) 1500)

// used to check gsm registration status
#define GM_CMD_GSM_STATUS					((char*) "AT+CREG?\x0d")
#define GM_CMD_GSM_STATUS_TIMEOUT			((uint16_t) 5000)
#define GM_GSM_RESPONSE						((char*) "+CREG: 0,1")

// used to check gprs registration status
// (180 second maximum documented timeout)
#define GM_CMD_GPRS_STATUS					((char*) "AT+CGATT?\x0d")
#define GM_CMD_GPRS_STATUS_TIMEOUT			((uint16_t) 5000)
#define GM_GPRS_RESPONSE					((char*) "+CGATT: 1")

// used to retrieve the current date/time
#define GM_CMD_NETWORK_TIME					((char*) "AT+CCLK?\x0d")
#define GM_CMD_NETWORK_TIME_TIMEOUT			((uint16_t) 1500)

// used to check received signal strength
#define GM_CMD_CHECK_RSSI					((char*) "AT+CSQ\x0d")
#define GM_CMD_CHECK_RSSI_TIMEOUT			((uint16_t) 5000)

// used to initiate transmission of an SMS message
// (must be followed by "<number>", then part 2; responds with prompt)
#define GM_SET_SMS_TEXT_P1					((char*) "AT+CMGS=\"")
#define GM_SET_SMS_TEXT_P2					((char*) "\"\x0d")
#define GM_SET_SMS_TEXT_TIMEOUT				((uint16_t) 5000)

// used to complete an SMS message, triggering transmission
// (180 second maximum documented timeout)
#define GM_SEND_SMS							((char*) "\x1a")
#define GM_SEND_SMS_TIMEOUT					((uint16_t) 30000)

// used to activate the first context, acquiring an IP address
// (context id=1, activate=1)
// (undocumented timing > 1500 milliseconds)
#define GM_ACTIVATE_CONTEXT					((char*) "AT#SGACT=1,1\x0d")
#define GM_ACTIVATE_CONTEXT_TIMEOUT			((uint16_t) 10000)

// used to deactivate the first context
// (context id=1, activate=0)
#define GM_DEACTIVATE_CONTEXT				((char*) "AT#SGACT=1,0\x0d")
#define GM_DEACTIVATE_CONTEXT_TIMEOUT		((uint16_t) 1500)

// used to initiate transmission of an email message
// (must be followed by "<destination address>", "<subject>", then part 2; responds with prompt)
#define GM_SET_EMAIL_TEXT_P1				((char*) "AT#EMAILD=\"")
#define GM_SET_EMAIL_TEXT_P2				((char*) "\"\x0d")
#define GM_SET_EMAIL_TEXT_TIMEOUT			((uint16_t) 5000)

// used to complete an email message, triggering transmission
// (undocumented timeout > 1500 milliseconds)
#define GM_SEND_EMAIL						((char*) "\x1a")
#define GM_SEND_EMAIL_TIMEOUT				((uint16_t) 65535)

// used to establish a tcp connection to a remote server
// (context id=1, protocol=tcp, port number=<pn>, address=<address>)
// (part 1 must be followed by "<port number>, ""<server address>", then part 2)
// (note: timeout value must be consistent with GM_IP_CONNECTION_TIMEOUT)
#define GM_TCP_CONNECT_P1					((char*) "AT#SD=1,0,")
#define GM_TCP_CONNECT_P2					((char*) "\"\x0d")
#define GM_TCP_CONNECT_TIMEOUT				((uint16_t) 31500)

// used to disconnect an active TCP connection
// (undocumented timing > 1500 milliseconds)
#define GM_TCP_DISCONNECT					((char*) "AT#SH=1\x0d")
#define GM_TCP_DISCONNECT_TIMEOUT			((uint16_t) 5000)

// used to escape into command mode
#define GM_COMMAND_MODE						((char*) "+++")
#define GM_COMMAND_MODE_TIMEOUT				((uint16_t) 3500)
//---


//---
// gm862 API constants
//---
// standard "OK" response from gm862
#define GM_OK_RESPONSE						((char*) "\x0d\x0aOK\x0d\x0a")

// standard "CONNECT" response from gm862
#define GM_CONNECT_RESPONSE					((char*) "\x0d\x0a""CONNECT\x0d\x0a")

// standard prompt response from gm862 (e.g., for SMS text)
#define GM_PROMPT_RESPONSE					((char*) "\x0d\x0a> ")
//---


//---
// type definitions
//---
// used to represent a date and time value
// note: the gmt_offset is expressed in quarters 
//       of an hour
typedef struct {
	uint8_t year;
	uint8_t month;
	uint8_t day;
	uint8_t hours;
	uint8_t minutes;
	uint8_t seconds;
	
	// (not currently in use)
	// uint8_t gmt_offset;		
} datetime_t;	

// used to configure the gm862's email settings
typedef struct {
	char* smtp_address;
	char* user_name;
	char* password;
	char* sender_address;
} email_config_t;
//---


// used to initialize the gm862
// note: see constraints on uart_config_t
void gm862_init(uart_config_t* uart_config);

// used to wake the gm862; return value indicates
// presence of modem in ready state
// requires: gm862 is initialized and asleep
bool gm862_wake();

// used to put the gm862 to sleep
// requires: gm862 is initialized and in command mode
void gm862_sleep();

// used to configure the default profile used by the gm862;
// intended to be invoked once per session; return value
// indicates success; on failure, device may be shutdown; 
// email_config may be null
// requires: gm862 is initialized and in command mode
bool gm862_set_default_profile(email_config_t* email_config);

// used to check whether the gm862 is gsm registered;
// return value indicates registration status
// requires: gm862 is initialized and in command mode
bool gm862_gsm_registered();

// used to check whether the gm862 is gprs registered;
// return value indicates registration status
// requires: gm862 is initialized and in command mode
bool gm862_gprs_registered();

// used to check the cellular signal; return value
// indicates strength (0-31; 99 reflects no signal)
// requires: gm862 is initialized, gsm registered, 
// and in command mode
uint8_t gm862_rssi();

// used to retrieve the current date and time;
// (note: the internal clock is synchronized with network time
//        at boot, but the synchronization is not instantaneous)
// requires: gm862 is initialized, gsm registered, and in 
//           command mode
datetime_t gm862_current_time();

// used to initiate an sms message to a null-terminated
// phone number; return value indicates result; successful
// call must be followed by transmission of the message
// data and a call to gm862_end_sms() 
// requires: strlen(number) = 10; gm862 is initialized, gsm 
//			 registered, and in command mode;
//			 [strlen(<message data>) <= 160]
bool gm862_start_sms(char* number);

// used to trigger transmission of an in-progress sms 
// message; return value indicates result
// requires: gm862 is initialized, gsm registered, and 
//           in sms mode;
//			 [strlen(<message data>) <= 160]
bool gm862_end_sms();

// used to send a null-terminated SMS message to a 
// null-terminated phone number; return value indicates
// transmission result
// requires: strlen(number) = 10; strlen(message) <= 160;
//           gm862 is initialized, gsm registered, and in 
//           command mode
bool gm862_send_sms(char* number, char* message);

// used to connect to the internet; return value is the 
// acquired IP address, or 0x00000000 if unsuccessful
// requires: gm862 is initialized, gsm registered, gprs 
//           registered, not connected to the internet, 
//           and in command mode
uint32_t gm862_acquire_ip();

// used to disconnect from the internet; return value 
// indicates success
// requires: gm862 is initialized, gsm registered, 
//           gprs registered, connected to the internet, 
//           and in command mode
bool gm862_drop_ip();

// used to initiate an email to a null-terminated address
// with a null-terminated subject; return value indicates 
// result; successful call must be followed by transmission 
// of the body data and a call to gm862_end_email()
// requires: gm862 is initialized, gsm registered,
//           gprs registered, connected to the internet,
//           and in command mode
bool gm862_start_email(char* dest_address, char* subject);

// used to trigger transmission of an in-progress email;
// return value indicates result
// requires: gm862 is initialized, gsm registered,
//           gprs registered, connected to the internet,
//           and in email mode
bool gm862_end_email();

// used to send an email to a null-terminated address, 
// with a specified null-terminated subject and body;
// return value indicates result
// requires: gm862 is initialized, gsm registered,
//           gprs registered, connected to the internet,
//           and in command mode
bool gm862_send_email(char* dest_address, char* subject, char* body);

// used to establish a tcp connection to a specified address
// and port; return value indicates success; if successful, 
// the device will be in data mode; if unsuccessful, the mode
// is unspecified
// requires: gm862 is initialized, gsm registered, gprs registered,
//			 connected to the internet, and in command mode
bool gm862_tcp_connect(char* address, uint16_t port);

// used to disconnect a tcp connection; return value 
// indicates success
// requires: gm862 is initialized and in command mode
bool gm862_tcp_disconnect();

// used to enter command mode; return value indicates success
// requires: gm862 is initialized and in data mode
bool gm862_enter_command_mode();

// used internally to initiate a (null-terminated) multi-string 
// command, or to send a complete command
// requires: gm862 is initialized and in command mode
void gm862_send_command(char* command);


//---
// data transmission functions
// (note: in current implementation, calls are delegated to  
//        uart_xxx() functions)
//---


// used to send a single byte through the gm862
// requires: gm862 is initialized and in { data mode, 
//           sms mode, email mode }
void gm862_send_byte(uint8_t data);

// used to send count bytes through the gm862
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
void gm862_send_bytes(uint8_t* data, uint8_t count);

// used to send a null-terminated character string
// through the gm862
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
void gm862_send_string(char* string);

// used to receive a byte from the gm862; the return value
// indicates whether a byte was (true) or was not (false)
// available; the call terminates when a byte is received
// or max_wait_ms milliseconds have elapsed without receiving
// a byte
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
bool gm862_receive_byte(uint8_t* data, uint16_t max_wait_ms);

// used to receive up to capacity bytes from the gm862; the
// call terminates when the capacity is reached or max_wait_ms
// milliseconds have elapsed without receiving a new byte;
// return value indicates total bytes received
// requires: gm862 is initialized and in { data mode,
//           sms mode, email mode }
uint8_t gm862_receive_bytes(uint8_t* data, uint8_t capacity, uint16_t max_wait_ms);


#endif

