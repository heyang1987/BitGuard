/**
 * 
 */
package edu.clemson.dsrg.bg.bean;

/**
 * This class represents a line in assembly code.
 * @author jonas
 *
 */
public class AssemblyNodeBean {
	public enum Type{
		directive,
		instruction,
		label,
		initialization
	}
	
	private Type type;
	private String keyword;
	private String operand1;
	private String operand2;
	private String operand3;
	
	public String getOperand3() {
		return operand3;
	}
	public void setOperand3(String operand3) {
		this.operand3 = operand3;
	}
	public Type getType() {
		return type;
	}
	public void setType(Type type) {
		this.type = type;
	}
	public String getKeyword() {
		return keyword;
	}
	public void setKeyword(String keyword) {
		this.keyword = keyword;
	}
	public String getOperand1() {
		return operand1;
	}
	public void setOperand1(String operand1) {
		this.operand1 = operand1;
	}
	public String getOperand2() {
		return operand2;
	}
	public void setOperand2(String operand2) {
		this.operand2 = operand2;
	}
	
}
