/*
 * i2c.c
 *
 * Created: 2/16/2013 11:27:57 PM
 *  Author: jonas
 */ 

#include "i2c.h"

void i2c_init(){
	TWCR |= 1<<TWEN;
	TWBR = 0x02;
	TWSR = 0x00;
}

void i2c_start()
{
	TWCR = (1<<TWEN)|(1<<TWINT)|(1<<TWSTA);
	while(!(TWCR & (1<<TWINT)));
}

void i2c_stop()
{
	TWCR = (1<<TWEN)|(1<<TWINT)|(1<<TWSTO);
}

void i2c_write(uint8_t data)
{
	TWDR = data;
	TWCR = (1<<TWEN)|(1<<TWINT);
	while(!(TWCR & (1<<TWINT)));
}

uint8_t i2c_read_then_ack()
{
    TWCR = (1<<TWINT)|(1<<TWEN)|(1<<TWEA);
    while ((TWCR & (1<<TWINT)) == 0);
    return TWDR;
}

uint8_t i2c_read_no_ack()
{
	TWCR = (1<<TWEN)|(1<<TWINT);
	while(!(TWCR & (1<<TWINT)));
	return TWDR;
}

uint8_t i2c_get_status()
{
    uint8_t status;
    //mask status
    status = TWSR & 0xF8;
    return status;
}