/*---
NOTES:
COMMANDS TO USE BEFORE USING TRANSMIT COMMAND and THEIR ORDER:
1) init_spi();
2) set_config();
3) power_management()
4) set_datarate()
5) trans_control_command()
6) transmit()

COMMANDS TO USE BEFORE USING RECEIVE COMMAND and THEIR ORDER:
1) init_spi();
2) set_config();
3) power_management()
4) set_datarate()
5) recv_control_command()
6) data_filter_command()
7) reset_fifo_interrupt_level()
8) set_fifo_interrupt_level()
9) status_read()
10) receive()

FOR QUICK SETTINGS USE (frequency: 434 MHz, datarate: 4.789272 kbps and FIFO interrupt level: 8 bits):
to transmit: init_transmit()
to receive: init_receive()
---*/

#include <avr/io.h>
#include <stdbool.h>
#include "bufferFunc.h"


#define data_baud_rate_1 ((uint16_t) 57600)
//#define receive_timeout ((uint16_t)(65537 - ((12*8000000)/(1024*data_baud_rate_1))))
#define receive_timeout ((uint16_t)(65537 - ((12*8000000)/(1024*57600))))



#define Tx_source_add ((uint8_t) 105)
#define Rx_source_add 125
//uint8_t Rx_source_add;
#define Tx ((uint8_t) 1) //0 receiver, 1 tranmitter
#define FREQUENCY ((uint16_t) 438)
//#define TimeToSyncShift 0
uint32_t TimeToSyncShift;
//#define TimeToSyncShift (30000*(Tx_source_add-101))
#define TimeToSyncBuffer ((uint32_t) 30000)
#define TimeToSyncRx ((uint32_t) 570000)
#define TimeToSyncTx ((uint32_t) 600000)
//#define RootNodeLeaf 2			// Root - 0, Node - 1, Leaf - 2
uint8_t RootNodeLeaf;			// Root - 0, Node - 1, Leaf - 2


//---
//FOR FUTURE USE
//---
#define RFM12_315 0
#define RFM12_434 1
#define RFM12_868 2
#define RFM12_915 3


//---
//REQUIRED IN POWER MANAGEMENT COMMAND
//---
typedef struct  
{
	uint8_t enable_receiver;
	uint8_t enable_baseband_block;
	uint8_t enable_transmitter;
	uint8_t enable_synthesizer;
	uint8_t enable_crystal;
	uint8_t enable_battery_detector;
	uint8_t enable_wakeup_timer;
	uint8_t disable_clock_pin;
} power_management_command;


typedef struct{
	uint8_t address_source;
	uint8_t address_destination;
	uint8_t flag;
	uint8_t length;
	uint8_t* payload;
	uint8_t crc;
}rfm12_frame_format;

rfm12_frame_format frame;


//---
//REQUIRED IN RECEIVER CONTROL COMMAND
//---
#define p20 1					// used for selecting between interrupt and vdi pin. p20 == true then vdi output else external interrupt input

#define VDI_FAST ((uint16_t)0x0000)			// vdi response fast
#define VDI_MEDIUM ((uint16_t)0x0100)		// vdi response medium
#define VDI_SLOW ((uint16_t)0x0200)			// vdi response slow
#define VDI_ALWAYS_ON ((uint16_t)0x0300)	// vdi response always on

#define BASEBAND_BANDWIDTH_400 ((uint8_t)0x20)
#define BASEBAND_BANDWIDTH_340 ((uint8_t)0x40)
#define BASEBAND_BANDWIDTH_270 ((uint8_t)0x60)
#define BASEBAND_BANDWIDTH_200 ((uint8_t)0x80)
#define BASEBAND_BANDWIDTH_134 ((uint8_t)0xA0)
#define BASEBAND_BANDWIDTH_67  ((uint8_t)0xC0)

#define	GAIN_0  ((uint8_t)0x00)
#define	GAIN_6  ((uint8_t)0x08)
#define	GAIN_14 ((uint8_t)0x10)
#define	GAIN_20 ((uint8_t)0x18)

#define DRSSI_THRESHOLD_103 ((uint8_t)0)
#define DRSSI_THRESHOLD_97  ((uint8_t)1)
#define DRSSI_THRESHOLD_91  ((uint8_t)2)
#define DRSSI_THRESHOLD_85  ((uint8_t)3)
#define DRSSI_THRESHOLD_79  ((uint8_t)4)
#define DRSSI_THRESHOLD_73  ((uint8_t)5)
#define DRSSI_THRESHOLD_67  ((uint8_t)6)
#define DRSSI_THRESHOLD_61  ((uint8_t)7)


//---
//REQUIRED IN TRANSMITTER CONTROL COMMAND
//---
#define OUTPUT_POWER_0  ((uint8_t)0)
#define OUTPUT_POWER_3  ((uint8_t)1)
#define OUTPUT_POWER_6  ((uint8_t)2)
#define OUTPUT_POWER_9  ((uint8_t)3)
#define OUTPUT_POWER_12 ((uint8_t)4)
#define OUTPUT_POWER_15 ((uint8_t)5)
#define OUTPUT_POWER_18 ((uint8_t)6)
#define OUTPUT_POWER_21 ((uint8_t)7)


//---
//REQUIRED FOR SPI
//---
#define SCK 5
#define MISO 4
#define MOSI 3
#define SS 2


#define load_capacitor 12.5
#define STATUS_READ() write(0x0000)
#define cs 0			// required in datarate function



void set_config(float frequency);	// This function is used to define the type of the RFM12 module used(freq of module).

void power_management(power_management_command command);	// This function is used to enable the modules present in RFM12.

void set_frequency(float frequency);	// This function is used to set the carrier frequency of the RFM12 module. It should be in the following range
/*
FOR 315 MHz BAND, 2.5 kHz RESOLUTION
310.24 to 319.75

FOR 433 MHz BAND, 2.5 kHz RESOLUTION
430.24 to 439.75

FOR 868 MHz BAND, 5.0 kHz RESOLUTION
860.48 to 879.51

FOR 915 MHz BAND, 7.5 kHz RESOLUTION
900.72 to 929.27
*/

void set_datarate(float datarate);	// This function is used to set the actual bit rate in transmit mode and expested bit rate in receive mode.

void recv_control_command(unsigned int vdi_response, uint8_t baseband_bandwidth, uint8_t gain, uint8_t threshold);

void set_fifo_interrupt_level(uint8_t bits);	// This function is used to set the syncron pattern and the fifo interrupt level.

void reset_fifo_interrupt_level(uint8_t bits);	// This function is used to reset the syncron pattern and the fifo interrupt level.

void trans_control_command(uint8_t sign,uint8_t number_mul_15kHz, uint8_t output_power); 

void data_filter_command(uint8_t clock_recovery_auto_lock, uint8_t clock_recovery_fast_mode, uint8_t data_filter_type, uint8_t threshold);

//void __attribute__((noinline)) transmit(rfm12_frame_format frame);	// This function is used to transmit a Character Array.

void __attribute__((noinline)) transmit(Buffer* data, uint8_t flag, uint8_t address);	// This function is used to transmit a Character Array.

//bool receive(char* data, uint8_t* flag, uint8_t* error, uint8_t* destination__address);	// This function is used to receive a byte of data. We have to give fifo intrrrupt level as input to this function.
bool receive(Buffer* data, uint8_t* flag, uint8_t* error, uint8_t* source__address, uint8_t* destination__address);

void init_spi();	// This function is used to initialize SPI.

void init_rfm12();

void init_transmit();	// This function can be used to directly transmit the data.

void init_receive();	// This function can be used to directly receive the data.

uint8_t crc_8(Buffer *payload);

//void transmit__correct(uint8_t destination__address);
//
//void transmit__error(uint8_t destination__address);
//
//bool received__data(char* data, uint8_t* destination__address);
bool received__data(Buffer* data, uint8_t* source__address, uint8_t* destination__address);

void rfm12_off();