/*
 * mma8452.h
 *
 * Created: 2/13/2013 3:54:14 PM
 *  Author: jonas
 */ 


#ifndef MMA8452_H_
#define MMA8452_H_

#include "i2c.h"
#include <avr/io.h>

// Device address.
// 0x1C if SA0 is low.
//#define MMA8452_ADDRESS 							0x1D
#define MMA8452_ADDRESS_READ						0x3B
#define MMA8452_ADDRESS_WRITE						0x3A

// Register addresses.
#define MMA8452_REGISTER_STATUS 					0x00
#define MMA8452_REGISTER_WHO_AM_I 					0x0D
#define MMA8452_REGISTER_XYZ_DATA_CFG				0x0E
#define MMA8452_REGISTER_CTRL_REG1					0x2A
#define MMA8452_REGISTER_CTRL_REG2					0x2B
#define MMA8452_REGISTER_CTRL_REG3					0x2C
#define MMA8452_REGISTER_CTRL_REG4					0x2D
#define MMA8452_REGISTER_CTRL_REG5					0x2E
#define MMA8452_REGISTER_OUT_X_MSB					0x01
#define MMA8452_INT_SOURCE							0x0C

#define MMA8452_MASK_CTRL_REG1_ACTIVE				0x01
#define MMA8452_MASK_CTRL_REG1_F_READ				0x02
#define MMA8452_MASK_CTRL_REG1_LNOISE				0x04
#define MMA8452_MASK_CTRL_REG1_DR					0x38

#define MMA8452_MASK_CTRL_REG2_RST					0x40

#define MMA8452_MASK_CTRL_REG3_PP_OD				0x01
#define MMA8452_MASK_CTRL_REG3_IPOL					0x02

#define MMA8452_MASK_CTRL_REG4_INT_EN_DRDY			0x01

#define MMA8452_MASK_CTRL_REG5_INT_CFG_DRDY			0x01

#define MMA8452_MASK_STATUS_ZYXDR					0x08

#define MMA8452_MASK_XYZ_DATA_CFG_FS				0x03
#define MMA8452_MASK_XYZ_DATA_CFG_HPF_OUT			0x10

#define MMA8452_MASK_INT_SOURCE_SRC_DRDY			0x01

#define MMA8452_BIT_XYZ_DATA_CFG_FS_2G				0x00
#define MMA8452_BIT_XYZ_DATA_CFG_FS_4G				0x01
#define MMA8452_BIT_XYZ_DATA_CFG_FS_8G				0x02


//TODO move this function to somewhere else.
void mma8452_configure_nvic();

uint8_t mma8452_init();

void mma8452_reset();

void mma8452_standby();

void mma8452_active();

void mma8452_scale_2g();

void mma8452_scale_4g();

void mma8452_scale_8g();

void mma8452_fast_mode_enable();

void mma8452_fast_mode_disable();

void mma8452_low_noise_enable();

void mma8452_low_noise_disable();

void mma8452_high_pass_filter_enable();

void mma8452_high_pass_filter_disable();

void mma8452_interrupt_pin_pp();

void mma8452_interrupt_pin_od();

void mma8452_interrupt_active_low();

void mma8452_interrupt_active_high();

void mma8452_data_ready_interrupt_enable();

void mma8452_data_ready_interrupt_disable();

void mma8452_set_data_ready_pin_int1();

void mma8452_set_data_ready_pin_int2();

uint8_t mma8452_set_data_rate(uint8_t rate);

uint8_t mma8452_get_scale();

uint8_t mma8452_is_xyz_data_ready();

uint8_t mma8452_is_interrupt_source_xyz_data_ready();

void mma8452_read_xyz_acceleration(uint16_t* data);

uint8_t mma8452_read_register(uint8_t address);

//uint8_t mma8452_read_registers(uint8_t address, uint8_t number, uint8_t* data);

//uint8_t mma8452_write_register(uint8_t address, uint8_t data);



#endif /* MMA8452_H_ */