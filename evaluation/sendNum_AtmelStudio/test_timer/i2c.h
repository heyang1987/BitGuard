/*
 * i2c.h
 *
 * Created: 2/16/2013 11:27:41 PM
 *  Author: jonas
 */ 


#ifndef I2C_H_
#define I2C_H_

#include <avr/io.h>

#define I2C_STATUS_START					0x08
#define I2C_STATUS_REPEAT_START				0x10
#define I2C_STATUS_SLAW_ACK					0x18
#define I2C_STATUS_SLAW_NACK				0x20
#define I2C_STATUS_DATA_TRANSMITTED_ACK		0x28
#define I2C_STATUS_DATA_TRANSMITTED_NACK	0x30

void i2c_init();

void i2c_start();

void i2c_stop();

void i2c_write(uint8_t data);

uint8_t i2c_read_then_ack();

uint8_t i2c_read_no_ack();

uint8_t i2c_get_status();


#endif /* I2C_H_ */