/**
 * 
 */
package edu.clemson.dsrg.bgr.uart;

/**
 * This bean represents the ports in a computer.
 * @author jonas
 *
 */
public class PortBean {
	/**
	 * Name of the port.
	 */
	private String name;
	/**
	 * Type of the port.
	 */
	private String type;
	/**
	 * If this port is owned by other applications.
	 */
	private boolean currentlyOwned;
	public String getName() {
		return name;
	}
	public void setName(String name) {
		this.name = name;
	}
	public String getType() {
		return type;
	}
	public void setType(String type) {
		this.type = type;
	}
	public boolean isCurrentlyOwned() {
		return currentlyOwned;
	}
	public void setCurrentlyOwned(boolean currentlyOwned) {
		this.currentlyOwned = currentlyOwned;
	}
}
