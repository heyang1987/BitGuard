/*
 * mma8452.c
 *
 * Created: 2/13/2013 3:51:27 PM
 *  Author: jonas
 */ 


#include "mma8452.h"


char buffer[256];

uint16_t mma8452_convert_to_counts(uint16_t data);
void mma8452_set_scale(uint8_t scale);
void mma8452_set_active(uint8_t enable);
void mma8452_set_fast_mode(uint8_t enable);
void mma8452_set_pp_od(uint8_t value);
void mma8452_set_interrupt_polarity(uint8_t polarity);
void mma8452_set_data_ready_interrupt(uint8_t enable);
void mma8452_set_data_ready_pin(uint8_t pin);



uint8_t mma8452_read_register(uint8_t register_address);
uint8_t mma8452_read_registers(uint8_t register_address, uint8_t number, uint8_t* data);
uint8_t mma8452_write_register(uint8_t register_address, uint8_t data);

void mma8452_configure_nvic(){
	
}

uint8_t mma8452_init() {
	uart_send_string("MMA8452 test started.\r\n");

	i2c_init();		
																	
	uart_send_string("I2C bus initialized.\r\n");
	
	uint8_t address = mma8452_read_register(MMA8452_REGISTER_WHO_AM_I);
	if( address == 0x2A ){
		uart_send_string("MMA8452 initialized.\r\n");
		return 0;
	} else {
		uart_send_string("MMA8452 NOT initialized.\r\n");
		return 1;
	}
}

void mma8452_reset(){
	mma8452_write_register( MMA8452_REGISTER_CTRL_REG2, MMA8452_MASK_CTRL_REG2_RST );
}

void mma8452_active(){
	/*
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG1 );
	mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data | MMA8452_MASK_CTRL_REG1_ACTIVE );
	*/
	mma8452_set_active(1);
}

void mma8452_standby(){
	/*
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG1 );
	mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data & ~MMA8452_MASK_CTRL_REG1_ACTIVE );
	*/
	mma8452_set_active(0);
}

void mma8452_scale_2g(){
	/*
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_XYZ_DATA_CFG );
	data = data & ~MMA8452_MASK_XYZ_DATA_CFG_FS;
	mma8452_write_register( MMA8452_REGISTER_XYZ_DATA_CFG, data | MMA8452_BIT_XYZ_DATA_CFG_FS_2G );
	*/
	mma8452_set_scale(2);
}

void mma8452_scale_4g(){
	/*
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_XYZ_DATA_CFG );
	data = data & ~MMA8452_MASK_XYZ_DATA_CFG_FS;
	mma8452_write_register( MMA8452_REGISTER_XYZ_DATA_CFG, data | MMA8452_BIT_XYZ_DATA_CFG_FS_4G );
	*/
	mma8452_set_scale(4);
}

void mma8452_scale_8g(){
	/*
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_XYZ_DATA_CFG );
	data = data & ~MMA8452_MASK_XYZ_DATA_CFG_FS;
	mma8452_write_register( MMA8452_REGISTER_XYZ_DATA_CFG, data | MMA8452_BIT_XYZ_DATA_CFG_FS_8G );
	*/
	mma8452_set_scale(8);
}

void mma8452_fast_mode_enable(){
	/*
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG1 );
	mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data | MMA8452_MASK_CTRL_REG1_F_READ );
	*/
	mma8452_set_fast_mode(1);
}

void mma8452_fast_mode_disable(){
	/*
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG1 );
	mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data & ~MMA8452_MASK_CTRL_REG1_F_READ );
	*/
	mma8452_set_fast_mode(0);
}

void mma8452_low_noise_enable(){
	mma8452_set_low_noise_mode(1);
}

void mma8452_low_noise_disable(){
	mma8452_set_low_noise_mode(0);
}

void mma8452_high_pass_filter_enable(){
	mma8452_set_high_pass_filter(1);
}

void mma8452_high_pass_filter_disable(){
	mma8452_set_high_pass_filter(0);
}

void mma8452_interrupt_pin_pp(){
	mma8452_set_pp_od(0);
}

void mma8452_interrupt_pin_od(){
	mma8452_set_pp_od(1);
}

void mma8452_interrupt_active_low(){
	mma8452_set_interrupt_polarity(0);
}

void mma8452_interrupt_active_high(){
	mma8452_set_interrupt_polarity(1);
}

void mma8452_data_ready_interrupt_enable(){
	mma8452_set_data_ready_interrupt(1);
}

void mma8452_data_ready_interrupt_disable(){
	mma8452_set_data_ready_interrupt(0);
}

void mma8452_set_data_ready_pin_int1(){
	mma8452_set_data_ready_pin(1);
}

void mma8452_set_data_ready_pin_int2(){
	mma8452_set_data_ready_pin(2);
}

/**
 * 0: 800Hz
 * 1: 400Hz
 * 2: 200Hz
 * 3: 100Hz
 * 4: 50Hz
 * 5: 12.5Hz
 * 6: 6.25Hz
 * 7: 1.56Hz
 */
uint8_t mma8452_set_data_rate(uint8_t rate){
	if(rate > 7){
		return 1;
	}
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG1 );
	data = data & ~MMA8452_MASK_CTRL_REG1_DR;
	mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data | (rate<<3) );
	return 0;
}

uint8_t mma8452_get_scale(){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_XYZ_DATA_CFG );
	data = data & MMA8452_MASK_XYZ_DATA_CFG_FS;
	switch(data){
	case 0:
		return 2;
	case 1:
		return 4;
	case 2:
		return 8;
	}
	return 0;
}

uint8_t mma8452_is_xyz_data_ready(){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_STATUS );
	data = data & MMA8452_MASK_STATUS_ZYXDR;
	return (data > 0);
}

uint8_t mma8452_is_interrupt_source_xyz_data_ready(){
	uint8_t data = mma8452_read_register( MMA8452_INT_SOURCE );
	data = data & MMA8452_MASK_INT_SOURCE_SRC_DRDY;
	return (data > 0);
}

void mma8452_read_xyz_acceleration(uint16_t* data){
	uint8_t rawData[6];
	mma8452_read_registers(MMA8452_REGISTER_OUT_X_MSB, 6, &rawData[0]);

	/*
	uint8_t i = 0;
	for (; i<6; i+=2) {
		data[i/2] = ((rawData[i] << 8) | rawData[i+1]) >> 4;  // Turn the MSB and LSB into a 12-bit value
		if (rawData[i] > 0x7F){  // If the number is negative, we have to make it so manually (no 12-bit data type)
			data[i/2] = ~data[i/2] + 1;
			data[i/2] *= -1;  // Transform into negative 2's complement #
		}
	}
	uint16_t x_value = 0;
	uint16_t y_value = 0;
	uint16_t z_value = 0;

	x_value = mma8452_convert_to_counts(data[0]);
	y_value = mma8452_convert_to_counts(data[1]);
	z_value = mma8452_convert_to_counts(data[2]);
	*/
	
	// Loop to calculate 12-bit ADC and g value for each axis
	for(int i = 0; i < 3 ; i++){
		int gCount = (rawData[i*2] << 8) | rawData[(i*2)+1];  //Combine the two 8 bit registers into one 12-bit number
		gCount >>= 4; //The registers are left align, here we right align the 12-bit integer
		// If the number is negative, we have to make it so manually (no 12-bit data type)
		if (rawData[i*2] > 0x7F){  
			gCount = ~gCount + 1;
			gCount *= -1;  // Transform into negative 2's complement #
		}
		data[i] = gCount; //Record this gCount into the 3 int array
	}
	
	sprintf(buffer, "%d:%d:%d\r\n", data[0], data[1], data[2]);
	//sprintf(buffer, "%d:%d:%d\r\n", x_value, y_value, z_value);
	uart_send_string(buffer);
}

//**************************** Private functions ****************************//
uint16_t mma8452_convert_to_counts(uint16_t data){
	uint8_t thousands = (uint8_t)((data >>2) / 1000);
	uint8_t temp = (data >>2) % 1000;
	uint8_t hundreds = (uint8_t)(temp / 100);
	temp %= 100;
	uint8_t tens = (uint8_t)(temp / 10);
	uint8_t ones = (uint8_t)(temp % 10);

	//sprintf(buffer, "The converted data: [%d][%d][%d][%d]\r\n", thousands, hundreds, tens, ones);
	//uart_send_string(buffer);
	return (uint16_t)(thousands * 1000 + hundreds * 100 + tens * 10 + ones);
}

void mma8452_set_scale(uint8_t scale){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_XYZ_DATA_CFG );
	data = data & ~MMA8452_MASK_XYZ_DATA_CFG_FS;
	switch(scale){
	case 2:
		mma8452_write_register( MMA8452_REGISTER_XYZ_DATA_CFG, data | MMA8452_BIT_XYZ_DATA_CFG_FS_2G );
		break;
	case 4:
		mma8452_write_register( MMA8452_REGISTER_XYZ_DATA_CFG, data | MMA8452_BIT_XYZ_DATA_CFG_FS_4G );
		break;
	case 8:
		mma8452_write_register( MMA8452_REGISTER_XYZ_DATA_CFG, data | MMA8452_BIT_XYZ_DATA_CFG_FS_8G );
		break;
	}
}
void mma8452_set_active(uint8_t enable){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG1 );
	if( enable > 0 ){
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data | MMA8452_MASK_CTRL_REG1_ACTIVE );
	} else {
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data & ~MMA8452_MASK_CTRL_REG1_ACTIVE );
	}
}
void mma8452_set_fast_mode(uint8_t enable){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG1 );
	if( enable > 0 ){
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data | MMA8452_MASK_CTRL_REG1_F_READ );
	} else {
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data & ~MMA8452_MASK_CTRL_REG1_F_READ );
	}
}


void mma8452_set_low_noise_mode(uint8_t enable){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG1 );
	if( enable > 0 ){
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data | MMA8452_MASK_CTRL_REG1_LNOISE );
	} else {
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG1, data & ~MMA8452_MASK_CTRL_REG1_LNOISE );
	}
}

void mma8452_set_high_pass_filter(uint8_t enable){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_XYZ_DATA_CFG );
	if( enable > 0 ){
		mma8452_write_register( MMA8452_REGISTER_XYZ_DATA_CFG, data | MMA8452_MASK_XYZ_DATA_CFG_HPF_OUT );
	} else {
		mma8452_write_register( MMA8452_REGISTER_XYZ_DATA_CFG, data & ~MMA8452_MASK_XYZ_DATA_CFG_HPF_OUT );
	}
}
/**
 *
 * 0: pull up
 * 1: open drain
 */
void mma8452_set_pp_od(uint8_t value){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG3 );
	if( value == 0 ){
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG3, data & ~MMA8452_MASK_CTRL_REG3_PP_OD );
	} else {
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG3, data | MMA8452_MASK_CTRL_REG3_PP_OD );
	}
}

/**
 * 1: high
 * 0: low
 */
void mma8452_set_interrupt_polarity(uint8_t polarity){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG3 );
	if( polarity > 0 ){
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG3, data | MMA8452_MASK_CTRL_REG3_IPOL );
	} else {
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG3, data & ~MMA8452_MASK_CTRL_REG3_IPOL );
	}
}

void mma8452_set_data_ready_interrupt(uint8_t enable){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG4 );
	if( enable > 0 ){
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG4, data | MMA8452_MASK_CTRL_REG4_INT_EN_DRDY );
	} else {
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG4, data & ~MMA8452_MASK_CTRL_REG4_INT_EN_DRDY );
	}
}

/**
 * 1: INT1
 * 2: INT2
 */
void mma8452_set_data_ready_pin(uint8_t pin){
	uint8_t data = mma8452_read_register( MMA8452_REGISTER_CTRL_REG5 );
	if( pin == 1 ){
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG5, data | MMA8452_MASK_CTRL_REG5_INT_CFG_DRDY );
	} else {
		mma8452_write_register( MMA8452_REGISTER_CTRL_REG5, data & ~MMA8452_MASK_CTRL_REG5_INT_CFG_DRDY );
	}
}

uint8_t mma8452_read_register(uint8_t register_address){
	i2c_start();
	i2c_write(MMA8452_ADDRESS_WRITE);	
	i2c_write(register_address);
	i2c_start();
	i2c_write(MMA8452_ADDRESS_READ);
	uint8_t result = i2c_read_no_ack();
	i2c_stop();
	return result;
}


uint8_t mma8452_read_registers(uint8_t register_address, uint8_t number, uint8_t* data){
	if( number < 1 ){
		return 1;
	}
	i2c_start();
	i2c_write(MMA8452_ADDRESS_WRITE);	
	i2c_write(register_address);
	i2c_start();
	i2c_write(MMA8452_ADDRESS_READ);
	uint8_t i = 0;
	uint8_t buffer[16];
	for(; i < number; i++){		
		if( i == number - 1 ){
			data[i] = i2c_read_no_ack();
		} else {
			data[i] = i2c_read_then_ack();
		}		
		//sprintf(buffer, "--->>%d\r\n", data[i]);
		//uart_send_string(buffer);
	}
	i2c_stop();
	return 0;
}

uint8_t mma8452_write_register(uint8_t register_address, uint8_t data){
	i2c_start();
	i2c_write(MMA8452_ADDRESS_WRITE);
	i2c_write(register_address);
	i2c_write(data);
	i2c_stop();

	return 1;
}
