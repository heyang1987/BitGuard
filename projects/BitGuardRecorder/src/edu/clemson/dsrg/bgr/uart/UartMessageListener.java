/**
 * 
 */
package edu.clemson.dsrg.bgr.uart;

/**
 * Classes that handle messages received from UART should implement this interface.
 * @author jonas
 *
 */
public interface UartMessageListener {
	/**
	 * The callback function for the received messages.
	 * @param message The received message.
	 */
	public void messageReceived(byte[] message);
	
	/**
	 * The call back function for the received byte.
	 * @param b The received byte.
	 */
	public void byteReceived(byte b);
}
