/**
 * 
 */
package edu.clemson.dsrg.bgr.uart;

import java.io.IOException;
import java.io.InputStream;
import java.io.OutputStream;
import java.util.ArrayList;
import java.util.Enumeration;
import java.util.List;
import java.util.TooManyListenersException;

import gnu.io.CommPort;
import gnu.io.CommPortIdentifier;
import gnu.io.NoSuchPortException;
import gnu.io.PortInUseException;
import gnu.io.SerialPort;
import gnu.io.SerialPortEvent;
import gnu.io.SerialPortEventListener;
import gnu.io.UnsupportedCommOperationException;

/**
 * The UART driver.
 * @author jonas
 *
 */
public class UartDriver {
	public static final String PORT_TYPE_I2C = "I2C";
	public static final String PORT_TYPE_PARALLEL = "PARALLEL";
	public static final String PORT_TYPE_RAW = "RAW";
	public static final String PORT_TYPE_RS485 = "RS485";
	public static final String PORT_TYPE_SERIAL = "SERIAL";
	
	public UartDriver(){
		
	}
	/**
	 * UART income message listener.
	 */
	private UartMessageListener uartMessageListener;
	/**
	 * The port instance.
	 */
	private CommPort commPort;
	/**
	 * The input stream.
	 */
	private InputStream in;
	/**
	 * The output stream.
	 */
	private OutputStream out;
	/**
	 * 
	 */
	private boolean connected;
	/**
	 * The error code
	 * @author jonas
	 *
	 */
	public static enum ErrorCode {
		SUCCESS,
		FAIL,
		BUSY,
		NOT_SERIAL
	}
	/**
	 * Get the list the all the ports.
	 * @return List of ports.
	 */
	public List<PortBean> scanPorts(){
		List<PortBean> portList = new ArrayList<PortBean>();
		Enumeration<CommPortIdentifier> ports = CommPortIdentifier.getPortIdentifiers();
		CommPortIdentifier temp;
		while( ports.hasMoreElements() ){
			temp = ports.nextElement();
			PortBean portBean = new PortBean();
			portBean.setName(temp.getName());
			portBean.setCurrentlyOwned(temp.isCurrentlyOwned());
			switch(temp.getPortType()){
				case CommPortIdentifier.PORT_I2C:
					portBean.setType(PORT_TYPE_I2C);
					break;
				case CommPortIdentifier.PORT_PARALLEL:
					portBean.setType(PORT_TYPE_PARALLEL);
					break;
				case CommPortIdentifier.PORT_RAW:
					portBean.setType(PORT_TYPE_RAW);
					break;
				case CommPortIdentifier.PORT_RS485:
					portBean.setType(PORT_TYPE_RS485);
					break;
				case CommPortIdentifier.PORT_SERIAL:
					portBean.setType(PORT_TYPE_SERIAL);
					portList.add(portBean);
					break;
			}
		}
		return portList;
	}
	
	/**
	 * Connect to the serial port.
	 * @param portName The name of the port.
	 * @param uartConfigurationBean Configuration bean.
	 * @return The result.
	 * @throws NoSuchPortException
	 * @throws PortInUseException
	 * @throws UnsupportedCommOperationException
	 * @throws IOException
	 * @throws TooManyListenersException
	 */
	public ErrorCode connect(String portName, UartConfigurationBean uartConfigurationBean) throws NoSuchPortException, PortInUseException, UnsupportedCommOperationException, IOException, TooManyListenersException{
		CommPortIdentifier portIdentifier = CommPortIdentifier.getPortIdentifier(portName);
		if (portIdentifier.isCurrentlyOwned()) {
			///System.out.println("Error: Port is currently in use");
			return ErrorCode.BUSY;
		} else {
			commPort = portIdentifier.open(this.getClass().getName(), 5);

			if (commPort instanceof SerialPort) {
				SerialPort serialPort = (SerialPort) commPort;
				serialPort.setSerialPortParams(
						uartConfigurationBean.getBaudRate(), 
						uartConfigurationBean.getDataBits(),
						uartConfigurationBean.getStopBits(),
						uartConfigurationBean.getParity()
					);
				in = serialPort.getInputStream();
				out = serialPort.getOutputStream();
				serialPort.addEventListener(new SerialReader());
				serialPort.notifyOnDataAvailable(true);
				
				this.connected = true;
				return ErrorCode.SUCCESS;
			} else {
				//System.out.println("Error: Only serial ports are supported.");
				return ErrorCode.NOT_SERIAL;
			}
		}
	}
	
	/**
	 * Write a byte to port.
	 * @param data The data.
	 * @throws IOException 
	 */
	public void writeToPort(byte data) throws IOException{
		this.out.write(data);
		out.flush();
	}
	/**
	 * Write data to port.
	 * @param data The data.
	 * @throws IOException 
	 */
	public void writeToPort(byte[] data) throws IOException{
		this.out.write(data, 0, data.length);
		out.flush();
	}
	
	/**
	 * Disconnect the port.
	 * @return The result.
	 */
	public ErrorCode disconnect(){
		try {
			in.close();
			out.close();
		} catch (IOException e) {
			e.printStackTrace();
			return ErrorCode.FAIL;
		}
		commPort.close();
		this.connected = false;
		return ErrorCode.SUCCESS;
	}
	
	/**
	 * Set the listener for incoming messages.
	 * @param listener
	 */
	public void setUartMessageListener(UartMessageListener listener){
		this.uartMessageListener = listener;
	}
	/**
	 * Get the connection status.
	 * @return If is current connected.
	 */
	public boolean isConnected() {
		return connected;
	}
	
	/**
	 * Get the port name.
	 * @return Port name.
	 */
	public String getPortName(){
		return this.commPort.getName();
	}
	
	/**
	 * This class listens the serial port event.
	 * @author jonas
	 *
	 */
	private class SerialReader implements SerialPortEventListener {
		// The data received each time.
		private int data;
		public void serialEvent(SerialPortEvent arg0) {
			try {
				while ( (data = in.read()) > -1 ) {
					uartMessageListener.byteReceived( (byte)data );
				}
			} catch (IOException e) {
				e.printStackTrace();
			}
		}
	}

	public static void main(String[] args) throws NoSuchPortException, PortInUseException, UnsupportedCommOperationException, IOException, TooManyListenersException, InterruptedException{
		UartDriver uart1 = new UartDriver();
		UartDriver uart2 = new UartDriver();
		
		UartConfigurationBean config = new UartConfigurationBean();
		config.setBaudRate(9600);
		config.setDataBits(SerialPort.DATABITS_8);
		config.setStopBits(SerialPort.STOPBITS_1);
		config.setParity(SerialPort.PARITY_NONE);
		
	
		uart1.connect("COM3", config);
		//uart2.connect("COM9", config);
		
		uart1.setUartMessageListener(new UartMessageListener(){
			public void messageReceived(byte[] message) {
				System.out.println("11>>" + new String(message));
			}

			public void byteReceived(byte b) {
				System.out.println("11++" + (char)b);
			}
		});
		
		/*uart2.setUartMessageListener(new UartMessageListener(){
			public void messageReceived(byte[] message) {
				System.out.println("22>>" + new String(message));
			}

			public void byteReceived(byte b) {
				System.out.println("22++" + (char)b);
			}
		});
		*/
		uart1.writeToPort("11111111111\r\n".getBytes());
		Thread.sleep(3000);
		//uart2.writeToPort("22222222222\r\n".getBytes());
		
		uart1.disconnect();
		//uart2.disconnect();
		System.exit(1);
	}
}
