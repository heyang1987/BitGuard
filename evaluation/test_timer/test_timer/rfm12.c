#include "rfm12.h"
#include <string.h>
#define F_CPU 8000000UL
#include <util/delay.h>


void init_spi()
{
	DDRB |= (1<<MOSI) | (1<<SCK) | (1<<SS);
	SPCR = (1<<SPE) | (1<<MSTR);
}


uint16_t __attribute__((noinline)) write(uint16_t cmd_data)
{
	uint16_t temp = 0;
	PORTB &= ~(1<<SS);
	SPDR = (cmd_data>>8);
	while(!(SPSR & (1<<SPIF)));
	temp = SPDR<<8 ;
	SPDR = (cmd_data);
	while(!(SPSR & (1<<SPIF)));
	temp |= SPDR ;
	PORTB |= (1<<SS);
	return temp;
}


void set_config(float frequency)
{
	uint8_t temp=0;
	if ( frequency >= 310.09 && frequency <= 319.7575)
	{
		temp = 0xC0;
	} 
	else if ( frequency >= 430.09 && frequency <= 439.7575)
	{
		temp = 0xD0;
	} 
	else if ( frequency >= 860.18 && frequency <= 879.515)
	{
		temp = 0xE0;
	} 
	else if ( frequency >= 900.27 && frequency <= 929.2725)
	{
		temp = 0xF0;
	} 
	
	temp += (((load_capacitor+0.25)/0.5) - 17.0) ;
	write(0x8000 | temp);
}


void power_management(power_management_command command)
{
	write(0x8200 | (command.enable_receiver << 7) | (command.enable_baseband_block<<6) | (command.enable_transmitter<<5) | (command.enable_synthesizer<<4) | (command.enable_crystal<<3) | (command.enable_battery_detector<<2) | (command.enable_wakeup_timer<<1) | command.disable_clock_pin);
}


void set_frequency(float frequency)
{
	uint16_t temp = 0 ;

	if ( frequency >= 310.09 && frequency <= 319.7575)
	{
		temp = ((frequency-310)/0.0025);
	}

	else if ( frequency >= 430.09 && frequency <= 439.7575)
	{
		temp = ((frequency-430)/0.0025);
	}

	else if ( frequency >= 860.18 && frequency <= 879.515)
	{
		temp = ((frequency-860)/0.0050);
	}

	else if ( frequency >= 900.27 && frequency <= 929.2725)
	{
		temp = ((frequency-900)/0.0075);
	}
	
	write(0xA000 | temp);

}


void set_datarate(float datarate)
{
	uint8_t temp = 1;
	if (datarate < 0.6)
	datarate = 0.6;
	else if (datarate > 115.2)
	datarate = 115.2;
	if (datarate < 3)
	temp = 8;
	temp = ((10000+0.5*(29*datarate*temp))/(29*datarate*temp)) - 1;
	write(0xC600 | temp);
}


void recv_control_command( unsigned int vdi_response, uint8_t baseband_bandwidth, uint8_t gain, uint8_t threshold)
{
	write(0x9000 | vdi_response | p20<<10 | baseband_bandwidth | gain | threshold);
}


void set_fifo_interrupt_level(uint8_t bits)
{
	write(0xCA03 | bits << 4);
}


void reset_fifo_interrupt_level(uint8_t bits)
{
	write(0xCA01 | bits << 4);
}


void data_filter_command(uint8_t clock_recovery_auto_lock, uint8_t clock_recovery_fast_mode, uint8_t data_filter_type, uint8_t threshold)
{
	write(0xC228 | clock_recovery_auto_lock << 7 | clock_recovery_fast_mode << 6 | data_filter_type << 4 | threshold);
}


void trans_control_command(uint8_t sign,uint8_t number_mul_15kHz, uint8_t output_power)
{
	write(0x9800 | (sign << 8) | (number_mul_15kHz << 4) | output_power);
}


void init_receive()
{
power_management_command command = {1,0,0,0,1,0,0,1};
power_management(command);
recv_control_command(VDI_FAST,BASEBAND_BANDWIDTH_134,GAIN_0,DRSSI_THRESHOLD_103);
data_filter_command(1,0,0,4);
reset_fifo_interrupt_level(8);
set_fifo_interrupt_level(8);
STATUS_READ();
}


void init_rfm12()
{
	float frequency = FREQUENCY , datarate = 57.6;
	init_spi();
	set_config(frequency);
	set_frequency(frequency);
	set_datarate(datarate);
}


void init_transmit()
{
	power_management_command command = {0,0,0,0,1,0,0,1};
	power_management(command);
	trans_control_command(0,5,OUTPUT_POWER_0);
}


void rfm12_off(){
	//power_management_command command = {0,0,0,0,1,0,0,1};
	power_management_command command = {0,0,0,0,0,0,0,0};
	power_management(command);
}


void transfer(uint8_t data)
{
	while(!(write(0x0000)&(0x8000)));
	write(0xB800 | data);
}


//void __attribute__((noinline)) transmit(rfm12_frame_format frame)
void __attribute__((noinline)) transmit(Buffer* data, uint8_t flag, uint8_t address)
{
	PCICR &= ~(1<<PCIE0);
	PCMSK0 &= ~(1<<PCINT0);
	int i;
	init_transmit();
	frame.flag = flag;
	if (Tx)
	{
		frame.address_source = Tx_source_add;
	} 
	else
	{
		frame.address_source = Rx_source_add;
	}
	frame.address_destination = address;
	frame.payload = data->buffer;
//	frame.length = strlen(frame.payload) + 1;
	frame.length = data->count + 1;
	//frame.crc = crc_8(frame.payload);
	frame.crc = crc_8(data);
	{
	write(0x8239);
	transfer(0xAA);
	transfer(0xAA);
	transfer(0xAA);
	transfer(0x2D);
	transfer(0xD4);
	
	transfer(frame.address_destination);
	transfer(frame.address_source);
	transfer(frame.flag);
	transfer(frame.length);
	//while (*frame.payload != '\0')
	for(i=0;i<data->count;i++)
		transfer(*(frame.payload++));
	transfer(frame.crc);
	
	transfer(0xAA);
	transfer(0xAA);
	transfer(0xAA);
	write(0x8201);
	}
	init_receive();	
	PCICR |= (1<<PCIE0);
	PCMSK0 |= (1<<PCINT0);
}


uint8_t __attribute__((noinline)) received(uint8_t bits)
{
	return  write(0xB000);
}


bool receive(Buffer* data, uint8_t* flag, uint8_t* error, uint8_t* source__address, uint8_t* destination__address)
{
	uint8_t i;
	i = received(8);
	*source__address=i;
	TIFR1 = 0x01;
	TCCR1A = 0 ;
	TCCR1B = 0x05 ;	// timer1 , normal mode, 1024 prescaler
	if (i == frame.address_source || i == Rx_source_add || i == 255)
	{
		TCNT1 = receive_timeout;
		while(!((PINB & 1<<0) == 0) && ((TIFR1 & 0x01)==0));
		//while(!((PIND & 1<<2) == 0) && ((TIFR1 & 0x01)==0));
		*destination__address = received(8);
		TCNT1 = receive_timeout;
		while(!((PINB & 1<<0) == 0) && ((TIFR1 & 0x01)==0));
		//while(!((PIND & 1<<2) == 0) && ((TIFR1 & 0x01)==0));
		*flag = received(8);
		TCNT1 = receive_timeout;
		while(!((PINB & 1<<0) == 0) && ((TIFR1 & 0x01)==0));
		//while(!((PIND & 1<<2) == 0) && ((TIFR1 & 0x01)==0));
		frame.length = received(8);
		for (i=0;i<frame.length;i++)
		{
			TCNT1 = receive_timeout;
			while(!((PINB & 1<<0) == 0) && ((TIFR1 & 0x01)==0));
			//while(!((PIND & 1<<2) == 0) && ((TIFR1 & 0x01)==0));
			data->buffer[i] = received(8);
			if (!(TIFR1 & 0x01)==0)
			{
				//usart_transmit("\ndata_notreceived......\n\r",25);
				*error = 'Y';
				break;
			}
		}
		//data[i] = '\0';
		TCCR1B = 0x00 ;					// timer1 stopped
		GTCCR |= (1 << PSRASY);		// clear prescaler
		TIFR1 = 0x01;
		
		data->count = frame.length;
		if (crc_8(data) == 0 && *error != 'Y'){	
			*error = 'N';
			//data->buffer[frame.length-1] = '\0';
			data->count = frame.length-1;
		}
		else
		*error = 'Y';
		init_receive();
		return true;
		//usart_transmit("\n\correct_sourceaddress.....\n\n\r");	
	}
	else
	{
		//usart_transmit("\n\nwrong_sourceaddress.....\n\n\r");
		init_receive();
		return false;	
	}	
}


uint8_t crc_8(Buffer *payload)
{
	uint16_t temp=0;
	uint8_t i=0,j=0;
	//temp = *(payload++);
	temp = payload->buffer[j++];
	
	//if (*payload == '\0')
	if(j == payload->count)
	temp = temp<<8;
	else
	//temp = temp<<8 | *payload;
	temp = temp<<8 | payload->buffer[j];
	
	//while (*payload != '\0')
	while (j != payload->count)
	{
		//temp |= *(payload++);
		temp |= (payload->buffer[j++]);
		for (i=0;i<8;i++)
		{
			if (temp & 0x8000)
			temp = temp ^ 0xEA80;
			temp = temp<<1;
		}
	}
	
	for (i=0;i<8;i++)
	{
		if (temp & 0x8000)
		temp = temp ^ 0xEA80;
		temp = temp<<1;
	}
	
	return temp>>8;
}

//
//void transmit__correct(uint8_t destination__address)
//{
	//char data[]="CORRECT\n\n\r";
	//
	////frame.flag = 'A';
	////frame.address_source = Rx_source_add;
	////frame.address_destination = destination__address;
	////frame.payload = data;
	////frame.length = strlen(frame.payload) + 1;
	////frame.crc = crc_8(frame.payload);
	//init_transmit();
	////_delay_ms(10);
	////transmit(frame);
	//transmit(data,'A',destination__address);
	//init_receive();
//}
//
//
//void transmit__error(uint8_t destination__address)
//{
	//char data[]="ERROR\n\n\r";
	//
	////frame.flag = 'A';
	////frame.address_source = Rx_source_add;
	////frame.address_destination = destination__address;
	////frame.payload = data;
	////frame.length = strlen(frame.payload) + 1;
	////frame.crc = crc_8(frame.payload);
	//init_transmit();
	////_delay_ms(10);
	////transmit(frame);
	//transmit(data,'A',destination__address);
	//init_receive();
//}


bool received__data(Buffer* data, uint8_t* source__address, uint8_t* destination__address)
{
	uint8_t flag = 'F', error = 'E';
	if (receive(data,&flag,&error,source__address,destination__address)) {
		_delay_us(100);											// this statement is used as time is required to switch between transmit and receive
		if (error == 'N' && flag == 'D') {
			if (*source__address != 255)
			{
				uint8_t buffer[1] = "C";
				Buffer buf;
				buf.buffer = buffer;
				buf.count = 1;
				transmit(&buf,'A',*destination__address);
			}
			return true;
		}
		else if (error == 'Y' && flag == 'D') {
			if (*source__address != 255)
			{
				uint8_t buffer[1]="E";
				Buffer buf;
				buf.buffer = buffer;
				buf.count = 1;
				transmit(&buf,'A',*destination__address);
			}
			return false;
		}
	}
	return false;
}