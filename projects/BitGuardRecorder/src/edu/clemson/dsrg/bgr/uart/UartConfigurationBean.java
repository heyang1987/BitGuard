/**
 * 
 */
package edu.clemson.dsrg.bgr.uart;


/**
 * The UART configuration bean.
 * @author jonas
 *
 */
public class UartConfigurationBean  {
	private int baudRate;
	private int dataBits;
	private int stopBits;
	private int parity;
	public int getBaudRate() {
		return baudRate;
	}
	public void setBaudRate(int baudRate) {
		this.baudRate = baudRate;
	}
	public int getDataBits() {
		return dataBits;
	}
	public void setDataBits(int dataBits) {
		this.dataBits = dataBits;
	}
	public int getStopBits() {
		return stopBits;
	}
	public void setStopBits(int stopBits) {
		this.stopBits = stopBits;
	}
	public int getParity() {
		return parity;
	}
	public void setParity(int parity) {
		this.parity = parity;
	}
	
}
